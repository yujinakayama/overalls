begin
  RSpec::Core::RakeTask.new do |task|
    task.verbose = false
  end
rescue NameError
end
