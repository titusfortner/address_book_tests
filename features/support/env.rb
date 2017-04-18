require 'rspec'
require 'watir'
require 'sauce_whisk'
require 'page-object'

require 'data_magic'
DataMagic.load 'data_magic.yml'

require 'page-object/page_factory'
World(PageObject::PageFactory, SauceHelpers)

require_relative '../support/pages/guinea_pig_page'
require_relative "../support/sauce_helpers"

Before do |scenario|
  @browser = initialize_browser("#{scenario.feature.name} - #{scenario.name}")
  start_applitools
end

After do |scenario|
  stop_applitools
  submit_results(@browser.wd.session_id, scenario.passed?)
  @browser.quit
end
