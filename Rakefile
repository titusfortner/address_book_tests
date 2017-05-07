require 'rspec/core/rake_task'
require 'parallel_cucumber'

ENV['PARALLEL_SPLIT_TEST_PROCESSES'] = '10'
@success = true

# Cucumber and RSpec can not be run at the same time
# The default task uses the runner based on the setting of ENV['TEST_RUNNER']
task :default do
	ENV['BUILD_TAG'] += "-#{ENV['TEST_RUNNER']}" if ENV['BUILD_TAG']
	ENV['JUNIT_DIR'] = 'junit_reports/test'
	FileUtils.mkpath(ENV['JUNIT_DIR'][/^[^\/]+/])
	begin
		@result = system "parallel_split_test spec/parallel_spec.rb --format d --out #{ENV['JUNIT_DIR']}.xml"
	ensure
		@success &= @result
	end
end
