FactoryGirl.define do
  factory :build do
    repository
    sequence(:name) { |n| "circleci-#{n}" }
    branch { %w(master feature).sample }
    parallelism { SecureRandom.random_number(3) + 1 }
    committed_at { Time.current - 15.minutes }
  end
end
