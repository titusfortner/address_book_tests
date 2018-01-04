ENV['USE_SAUCE'] ||= 'false'
ENV['HEROKU'] ||= 'false'

require "watir_drops"
require "watir_model"
require "config_model"
require "require_all"
require 'webdrivers'
require 'ui2api'
require 'watigiri'

require_rel 'support'

log = Logger.new(STDOUT)
log.level = :info
RestClient.log = log

include AddressBook

RSpec.configure do |config|
  @config = Model::Config.new

  require_rel "support/sauce_helpers" if @config.use_sauce

  Site.base_url = @config.base_url
  UI2API::Base.base_url = Site.base_url

  config.include SauceLabs if @config.use_sauce

  config.before(:each) do
    @config = Model::Config.new
    @browser = if @config.use_sauce
                 initialize_driver(test.full_description)
               else
                 Watir::Browser.new
               end

    WatirDrops::PageObject.browser = @browser
    Site.browser = @browser
    @site = Site.new
  end

  config.after(:each) do
    submit_results(@browser, !example.exception) if @config.use_sauce

    @browser.quit
  end
end
