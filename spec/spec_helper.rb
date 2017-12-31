ENV['USE_SAUCE'] ||= 'false'
ENV['HEROKU'] ||= 'false'

require "watir_drops"
require "watir_model"
require "require_all"
require 'webdrivers'
require 'watir_api'
require 'watigiri'

require_rel "support/apis"
require_rel "support/site"
require_rel "support/data"
require_rel "support/pages"

log = Logger.new(STDOUT)
log.level = :info
RestClient.log = log

def sauce?
  ENV['USE_SAUCE'] == 'true'
end

require_rel "support/sauce_helpers" if sauce?

include AddressBook

Site.base_url = unless ENV['HEROKU'] == 'true'
                  'https://address-book-example.herokuapp.com'
                else
                  'http://localhost:3000'
                end
WatirApi::Base.base_url = Site.base_url

RSpec.configure do |config|
  config.include SauceHelpers if sauce?

  config.before(:each) do
    @browser = if sauce?
                 initialize_driver(test.full_description)
               else
                 Watir::Browser.new
               end

    WatirDrops::PageObject.browser = @browser
    Site.browser = @browser
  end

  config.after(:each) do
    submit_results(@browser, !example.exception) if sauce?

    @browser.quit
  end
end
