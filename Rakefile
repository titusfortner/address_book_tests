require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

desc 'Run tests locally in serial'
task :default => :spec

desc 'Run tests on Sauce in serial'
task :sauce_serial do
  ENV['USE_SAUCE'] = 'true'
  ENV['SAUCE_START_TIME'] = Time.now.to_i.to_s
  Rake::Task[:spec].execute
end

desc 'Run tests on Sauce in parallel'
task :sauce_parallel do
  ENV['USE_SAUCE'] = 'true'
  ENV['SAUCE_START_TIME'] = Time.now.to_i.to_s
  ENV['PARALLEL_SPLIT_TEST_PROCESSES'] = '10'

  system 'parallel_split_test spec'
end
