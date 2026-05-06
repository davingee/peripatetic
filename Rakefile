require "bundler/gem_tasks"

task default: :spec

require "rspec/core/rake_task"
RSpec::Core::RakeTask.new(:spec) do |task|
  task.pattern = "test/spec/**/*_spec.rb"
end
