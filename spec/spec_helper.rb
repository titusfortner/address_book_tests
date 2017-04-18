require "watir"
require "watir_drops"
require "watir_model"
require "rspec"
require "sauce_whisk"
require_relative "../support/sauce_helpers"

require_relative '../config/data/watir_model'
require_relative 'pages/guinea_pig_page'

RSpec.configure do |config|
  config.include SauceHelpers

  config.before(:each) do |test|
    @browser = initialize_browser(test.full_description)
    start_applitools
  end

  config.after(:each) do |example|
    stop_applitools
    submit_results(@browser.wd.session_id, !example.exception)
    @browser.quit
  end
end

