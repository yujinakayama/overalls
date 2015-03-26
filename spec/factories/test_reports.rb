# rubocop:disable LineLength
FactoryGirl.define do
  factory :test_report do
    json do
      repository = create(:repository)
      %({"repo_token":"#{repository.token}","source_files":[{"name":"lib/safedep/abstract_dependency.rb","blob_id":"f5bd987c92f957736a1de8a460dbb212f6382407","coverage":"[1,null,1,1,1,null,1,1261,433,433,null,null,1,0,null,null,1,156,156,156,null,null,1,94,null,null,1,0,null,null,1,36,null,null,1,48,null,23,17,null,6,null,null,null,1,12,null,null,1,null,1,9,null,null,1,111,null,null,1,98,null,null,1,0,null,null,1,6,null,null,null]","covered_percent":92.11,"covered_strength":80.9,"line_counts":{"total":71,"covered":35,"missed":3}},{"name":"lib/safedep/abstract_gemfile.rb","blob_id":"7157c4f6765b8682a2de6480aefb8acde92dc5db","coverage":"[1,1,null,1,1,1,null,1,52,null,null,1,102,null,null,1,null,1105,156,44,null,null,1,18,18,null,null,1,null,1,0,null,null,1,null,42,42,42,42,null,null,1,174,null,null,1,84,null,null,null]","covered_percent":96.43,"covered_strength":69.1,"line_counts":{"total":50,"covered":27,"missed":1}},{"name":"lib/safedep/cli.rb","blob_id":"b6ae6b9b055f95b1b26a567a1bb55db7fd0c07df","coverage":"[1,1,null,1,1,1,0,null,null,1,5,null,5,5,null,1,null,1,null,3,3,null,null,1,10,null,null,null]","covered_percent":93.75,"covered_strength":2.5,"line_counts":{"total":28,"covered":15,"missed":1}},{"name":"lib/safedep/cli/option_parser.rb","blob_id":"044bc53156485d62aac3228b2f5c1a08d3c8191b","coverage":"[1,1,1,null,1,1,1,null,1,5,5,null,null,1,5,5,5,null,null,1,null,1,5,0,null,null,5,0,0,null,null,null,1,20,10,10,null,null,1,null,5,5,5,5,15,null,null,1,10,null,null,1,null,null,null,null,null,null,null,10,null,null,null]","covered_percent":91.18,"covered_strength":4.2,"line_counts":{"total":63,"covered":31,"missed":3}},{"name":"lib/safedep/configuration.rb","blob_id":"488fc590d296e025f925bfc0ac459575dc4181ca","coverage":"[1,1,1,21,null,null,1,1,null,null,null]","covered_percent":100.0,"covered_strength":4.3,"line_counts":{"total":11,"covered":6,"missed":0}},{"name":"lib/safedep/error.rb","blob_id":"4964d3d2172d95de3120510d771cc937291240ca","coverage":"[1,1,null]","covered_percent":100.0,"covered_strength":1.0,"line_counts":{"total":3,"covered":2,"missed":0}},{"name":"lib/safedep/gemfile.rb","blob_id":"d1e5f265a0318a9bc3fb3244e6461fa29e3729e9","coverage":"[1,null,1,1,1,null,1,null,1,773,null,null,null]","covered_percent":100.0,"covered_strength":111.3,"line_counts":{"total":13,"covered":7,"missed":0}},{"name":"lib/safedep/gemfile/dependency.rb","blob_id":"2090371d9da7cb33fe857dedb23fd46c677bcf51","coverage":"[1,1,1,null,1,1,1,1,null,1,null,1,279,null,null,1,26,null,null,1,62,null,null,1,null,1,23,21,60,null,null,1,23,null,null,null,1,39,null,null,1,48,null,48,18,null,null,null,null,null,1,86,null,44,42,42,null,null,null,null,null]","covered_percent":100.0,"covered_strength":27.4,"line_counts":{"total":61,"covered":32,"missed":0}},{"name":"lib/safedep/gemfile_lock.rb","blob_id":"4e3a17dc2a1e6e218cd64d4989c651b2dff3ec6a","coverage":"[1,1,null,1,1,1,null,1,21,null,null,1,170,null,null,1,18,null,null,1,null,1,null,8,8,8,null,null,1,8,null,null,null]","covered_percent":100.0,"covered_strength":14.0,"line_counts":{"total":33,"covered":18,"missed":0}},{"name":"lib/safedep/gemspec.rb","blob_id":"91514627941e8df8cbe66957227243c803502dba","coverage":"[1,null,1,1,1,null,1,null,1,488,null,null,null]","covered_percent":100.0,"covered_strength":70.6,"line_counts":{"total":13,"covered":7,"missed":0}},{"name":"lib/safedep/gemspec/dependency.rb","blob_id":"b5488086c72d0fde17ca5848eda9f4474f3dd933","coverage":"[1,1,null,1,1,1,1,null,1,null,1,154,null,null,1,9,null,1,null,8,null,null,null,1,null,null,1,25,null,null,null,null]","covered_percent":100.0,"covered_strength":13.0,"line_counts":{"total":32,"covered":16,"missed":0}},{"name":"lib/safedep/literal.rb","blob_id":"d5d895fffe750be50daa2edc36df61a18da7ac3e","coverage":"[1,1,1,null,1,83,null,null,1,121,null,106,1,6,null,79,1,4,12,2,null,null,null,1,1,1,1,1,null,null,1,12,null,null,1,12,13,13,13,null,null,null,1,6,2,null,null,null]","covered_percent":100.0,"covered_strength":16.6,"line_counts":{"total":48,"covered":30,"missed":0}},{"name":"lib/safedep/policy/sem_ver.rb","blob_id":"3664e1a5cc91b2a373f9dfd36c2a7a1beed937ad","coverage":"[1,1,1,1,null,1,22,null,null,1,22,22,null,0,null,null,22,null,null,1,22,22,null,3,3,null,null,null,null,1,null,1,22,null,22,66,60,null,6,null,null,null,22,null,null,1,25,25,null,null,null,null]","covered_percent":96.3,"covered_strength":14.7,"line_counts":{"total":52,"covered":26,"missed":1}},{"name":"lib/safedep/runner.rb","blob_id":"bf45f8ff96dd128d7ed5fff1155e9898d278dfcc","coverage":"[1,1,1,1,1,1,null,1,1,1,1,null,1,null,1,14,null,null,1,13,null,8,21,null,15,null,15,1,null,null,null,14,null,null,7,null,null,1,13,9,null,null,1,9,null,null,1,15,null,null,1,null,8,8,8,null,null,1,null,9,8,17,null,null,1,null,13,9,29,null,null,1,22,5,5,5,null,null,1,21,21,69,null,null,1,14,null,null,null]","covered_percent":100.0,"covered_strength":8.6,"line_counts":{"total":89,"covered":52,"missed":0}},{"name":"lib/safedep/util.rb","blob_id":"e96dd16c338aacdd336757c23d3d3c57873a4f90","coverage":"[1,1,1,null,1,23,null,23,9,9,null,null,23,null,null,null]","covered_percent":100.0,"covered_strength":10.1,"line_counts":{"total":16,"covered":9,"missed":0}}],"run_at":1427305935,"covered_percent":97.2,"covered_strength":28.77,"line_counts":{"total":583,"covered":313,"missed":9},"partial":false,"git":{"head":"7a5b3cf0658cecdb898374e984f6e714392c4c8e","committed_at":1421049862,"branch":"master"},"environment":{"test_framework":"rspec","pwd":"/Users/me/Projects/safedep","rails_root":null,"simplecov_root":"/Users/me/Projects/safedep","gem_version":"0.4.7"},"ci_service":{"name":"circlci","build_identifier":"17221","branch":"overalls","commit_sha":"bb2293e78699e2c3ab594a754340b6a17e1e9d49","node_index":"0","node_total":"2"}})
    end
  end
end
