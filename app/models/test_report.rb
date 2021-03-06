# rubocop:disable LineLength
#
# {"test_report"=>
#   {"repo_token"=>"some_token",
#    "source_files"=>
#     [{"name"=>"lib/safedep/abstract_dependency.rb",
#       "blob_id"=>"f5bd987c92f957736a1de8a460dbb212f6382407",
#       "coverage"=>
#        "[1,null,1,1,1,null,1,1261,433,433,null,null,1,0,null,null,1,156,156,156,null,null,1,94,null,null,1,0,null,null,1,36,null,null,1,48,null,23,17,null,6,null,null,null,1,12,null,null,1,null,1,9,null,null,1,111,null,null,1,98,null,null,1,0,null,null,1,6,null,null,null]",
#       "covered_percent"=>92.11,
#       "covered_strength"=>80.9,
#       "line_counts"=>{"total"=>71, "covered"=>35, "missed"=>3}},
#      {"name"=>"lib/safedep/abstract_gemfile.rb",
#       "blob_id"=>"7157c4f6765b8682a2de6480aefb8acde92dc5db",
#       "coverage"=>
#        "[1,1,null,1,1,1,null,1,52,null,null,1,102,null,null,1,null,1105,156,44,null,null,1,18,18,null,null,1,null,1,0,null,null,1,null,42,42,42,42,null,null,1,174,null,null,1,84,null,null,null]",
#       "covered_percent"=>96.43,
#       "covered_strength"=>69.1,
#       "line_counts"=>{"total"=>50, "covered"=>27, "missed"=>1}},
#      {"name"=>"lib/safedep/util.rb",
#       "blob_id"=>"e96dd16c338aacdd336757c23d3d3c57873a4f90",
#       "coverage"=>"[1,1,1,null,1,23,null,23,9,9,null,null,23,null,null,null]",
#       "covered_percent"=>100.0,
#       "covered_strength"=>10.1,
#       "line_counts"=>{"total"=>16, "covered"=>9, "missed"=>0}}],
#    "run_at"=>1427297008,
#    "covered_percent"=>97.2,
#    "covered_strength"=>28.77,
#    "line_counts"=>{"total"=>583, "covered"=>313, "missed"=>9},
#    "partial"=>false,
#    "git"=>
#     {"head"=>"7a5b3cf0658cecdb898374e984f6e714392c4c8e",
#      "committed_at"=>1421049862,
#      "branch"=>"master"},
#    "environment"=>
#     {"test_framework"=>"rspec",
#      "pwd"=>"/Users/me/Projects/safedep",
#      "rails_root"=>nil,
#      "simplecov_root"=>"/Users/me/Projects/safedep",
#      "gem_version"=>"0.4.7"},
#    "ci_service"=>
#     {"name"=>"circlci",
#      "build_identifier"=>17221,
#      "branch"=>"overalls",
#      "commit_sha"=>"bb2293e78699e2c3ab594a754340b6a17e1e9d49",
#      "node_index"=>0,
#      "node_total"=>2}}}
#
# rubocop:enable LineLength
class TestReport < ActiveRecord::Base
  belongs_to :build

  validates :build_id, presence: true
  validates :covered_percent, presence: true
  validates :run_at, presence: true
  validates :gzipped_json, presence: true

  delegate :ci_service, :covered_strength, :environment, :git, :line_counts, :repo_token,
           :source_files,
           to: :data

  before_validation on: :create do
    self.build ||= repository.builds.find_by(name: build_name) if repository
    self.build ||= Build.create(seed_test_report: self)
    self.covered_percent ||= data.covered_percent
    self.run_at ||= Time.at(data.run_at)
  end

  after_create do
    build.aggregate!
  end

  def repository
    Repository.find_by(token: repo_token)
  end

  def data
    @data ||= JSON.parse(json, object_class: OpenStruct)
  end

  def json
    ActiveSupport::Gzip.decompress(gzipped_json)
  end

  def json=(json)
    slimmed_json = slim_json(json)
    self.gzipped_json = ActiveSupport::Gzip.compress(slimmed_json)
    @data = nil
  end

  def keys
    data.each_pair.map(&:first)
  end

  def build_name
    service = ci_service.name || 'local'
    identifier = ci_service.build_identifier || Time.at(git.committed_at).strftime('%Y%m%d_%H%M%S')
    "#{service}-#{identifier}"
  end

  def partial?
    data.partial || data.ci_service.node_total.to_i > 1
  end

  private

  def slim_json(json)
    hash = JSON.parse(json, symbolize_names: true)

    hash[:source_files].each do |source_file|
      source_file.delete(:coverage)
    end

    JSON.generate(hash)
  end
end
