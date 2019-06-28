ENV['USE_SAUCE'] ||= 'false'
ENV['HEROKU'] ||= 'false'

require "watir_drops"
require "watir_model"
require "config_model"
require "require_all"
require 'webdrivers'
require 'ui2api'
require 'watigiri'
require 'madison'

require_rel 'support'

log = Logger.new(STDOUT)
log.level = :info
RestClient.log = log

include AddressBook

RSpec.configure do |config|
  @config = Model::Config.new

  require_rel "support/helpers/sauce_labs" if @config.use_sauce

  Site::AddressBook.base_url = @config.base_url
  UI2API::Base.base_url = Site::AddressBook.base_url

  config.include SauceLabs if @config.use_sauce

  config.before(:each) do |test|
    @config = Model::Config.new
    @browser = if @config.use_sauce
                 initialize_driver(test.full_description)
               else
                 Watir::Browser.new
               end

    WatirDrops::PageObject.browser = @browser
    Site::AddressBook.browser = @browser
    @site = Site::AddressBook.new
  end

  config.after(:each) do |test|
    submit_results(@browser, !test.exception) if @config.use_sauce

    @browser.quit
  end
end
