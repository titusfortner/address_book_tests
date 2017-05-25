module AddressBook
  class AddressShow < Page::Base

    # Define url represented by page object if appropriate
    # page_url {  }


    # Specify full Watir locator inside block
    # element(:foo) { browser.div(id: 'foo') }

    element(:first_name) {  }
    element(:last_name) {  }
    element(:street_address) {  }
    element(:secondary_address) {  }
    element(:city) {  }
    element(:state) {  }
    element(:zip_code) {  }

  end
end
