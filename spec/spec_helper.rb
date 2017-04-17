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
    @name = test.full_description
    @browser = initialize_browser(@name)
    @eyes = start_applitools
  end

  config.after(:each) do |example|
    stop_applitools(@eyes, @name)
    submit_results(@browser.wd.session_id, !example.exception)
  end
end

