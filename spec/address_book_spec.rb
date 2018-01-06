require 'spec_helper'

RSpec.describe AddressBook do
  it "opens a browser" do
    browser = Site::AddressBook.browser
    expect(browser).to_not be_nil
  end
end
