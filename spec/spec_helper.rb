require "watir_drops"
require "watir_model"
require "require_all"
require_rel "support/data"
require_rel "support/pages"
include AddressBook

if ENV['USE_SAUCE'] == 'true'
  require_rel 'support/sauce_helpers'
end

RSpec.configure do |config|
  config.include SauceHelpers if ENV['USE_SAUCE'] == 'true'

  config.before(:each) do
    @browser = if ENV['USE_SAUCE'] == 'true'
                 initialize_driver(test.full_description)
               else
                 Watir::Browser.new
               end

    WatirDrops::PageObject.browser = @browser
  end

  config.after(:each) do
    @browser.quit
  end
end
