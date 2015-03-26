class Build < ActiveRecord::Base
  belongs_to :repository
  has_many :test_reports, dependent: :destroy

  attr_accessor :seed_test_report

  validates :repository_id, presence: true
  validates :name, presence: true, uniqueness: { scope: :repository_id }
  validates :branch, presence: true
  validates :parallelism, presence: true
  validates :committed_at, presence: true

  before_validation on: :create do
    next unless seed_test_report
    self.repository ||= Repository.find_by(token: seed_test_report.repo_token)
    self.name ||= seed_test_report.build_name
    self.branch ||= seed_test_report.git.branch
    self.parallelism ||= seed_test_report.ci_service.node_total || 1
    self.committed_at ||= Time.at(seed_test_report.git.committed_at)
  end

  def completed?
    test_reports.count >= parallelism
  end
end
