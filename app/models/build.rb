class Build < ActiveRecord::Base
  belongs_to :repository
  has_many :test_reports, dependent: :destroy

  attr_accessor :seed_test_report

  validates :repository_id, presence: true
  validates :name, presence: true, uniqueness: { scope: :repository_id }
  validates :branch, presence: true
  validates :parallelism, presence: true
  validates :committed_at, presence: true

  delegate :git, to: :test_report, allow_nil: true

  before_validation on: :create do
    next unless seed_test_report
    self.repository ||= Repository.find_by(token: seed_test_report.repo_token)
    self.name ||= seed_test_report.build_name
    self.branch ||= seed_test_report.git.branch
    self.parallelism ||= seed_test_report.ci_service.node_total || 1
    self.committed_at ||= Time.at(seed_test_report.git.committed_at)
  end

  def aggregate!
    return unless completed?
    self.covered_percent = calculate_covered_percent
    save!
  end

  def completed?
    test_reports.count >= parallelism
  end

  def base_build
    repository.main_branch_builds
      .where('committed_at < ?', committed_at).order(committed_at: :desc).first
  end

  def source_files
    @source_files ||= test_reports.each_with_object([]) do |test_report, all_source_files|
      all_source_files.concat(test_report.source_files)
    end
  end

  def test_report
    test_reports.first
  end

  def as_json(*)
    {
               branch: branch,
         committed_at: committed_at,
            completed: completed?,
      covered_percent: covered_percent,
                  sha: git.head
    }
  end

  private

  # https://github.com/colszowka/simplecov/blob/v0.9.2/lib/simplecov/file_list.rb#L33-L38
  def calculate_covered_percent
    return 100.0 if source_files.empty? || line_count == 0
    Float(covered_line_count * 100.0 / line_count)
  end

  def line_count
    @line_count ||= source_files.reduce(0) do |total, source_file|
      total + source_file.line_counts.covered + source_file.line_counts.missed
    end
  end

  def covered_line_count
    @covered_line_count ||= source_files.reduce(0) do |total, source_file|
      total + source_file.line_counts.covered
    end
  end
end
