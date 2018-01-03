ENV['USE_SAUCE'] ||= 'false'
ENV['HEROKU'] ||= 'false'

require "watir_drops"
require "watir_model"
require "require_all"
require 'webdrivers'
require 'ui2api'
require 'watigiri'

require_rel 'support'

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
UI2API::Base.base_url = Site.base_url

RSpec.configure do |config|
  config.include SauceLabs if sauce?

  config.before(:each) do
    @browser = if sauce?
                 initialize_driver(test.full_description)
               else
                 Watir::Browser.new
               end

    WatirDrops::PageObject.browser = @browser
    Site.browser = @browser
    @site = Site.new
  end

  config.after(:each) do
    submit_results(@browser, !example.exception) if sauce?

    @browser.quit
  end
end
