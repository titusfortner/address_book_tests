require "watir_drops"
require "watir_model"
require "config_model"
require 'webdrivers'
require 'ui2api'
require 'watigiri'
require "require_all"
require_rel 'support'

include AddressBook

WatirModel.yml_directory = 'spec/support/config/data/'

RSpec.configure do |config|
  @config = Model::Config.new

  require_rel "support/helpers/sauce_labs" if @config.use_sauce

  Site::AddressBook.base_url = @config.base_url
  UI2API::Base.base_url = Site::AddressBook.base_url

  config.include SauceLabs if @config.use_sauce
  config.include Page

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

  config.after(:each) do |example|
    submit_results(@browser, !example.exception) if @config.use_sauce
    @browser.quit
  end
end
