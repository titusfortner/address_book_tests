ENV['USE_SAUCE'] ||= 'false'
ENV['BASE_URL'] ||= "https://address-book-example.herokuapp.com/"

require "watir_drops"
require "watir_model"
require "require_all"
require_rel "support/data"
require_rel "support/pages"
require_rel "support/site"
require_rel 'support/sauce_helpers' if ENV['USE_SAUCE'] == 'true'

include AddressBook
include Page

RSpec.configure do |config|
  config.include SauceHelpers if ENV['USE_SAUCE'] == 'true'

  config.before(:each) do |test|
    @browser = if ENV['USE_SAUCE'] == 'true'
                 initialize_driver(test.full_description)
               else
                 Watir::Browser.new
               end

    Base.browser = @browser
    Site.base_url = ENV['BASE_URL']
  end

  config.after(:each) do
    submit_results(@browser.wd.session_id, !test.exception) if ENV['USE_SAUCE'] == 'true'
    @browser.quit
  end
end
