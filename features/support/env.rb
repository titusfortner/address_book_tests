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
  @name = "#{scenario.feature.name} - #{scenario.name}"
  @browser = initialize_browser(@name)
  @eyes = start_applitools
end

After do |scenario|
  stop_applitools(@eyes, @name)
  submit_results(@browser.wd.session_id, scenario.passed?)
end
