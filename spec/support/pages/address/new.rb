module AddressBook::Address
  class New < AddressBook::Base

    page_url { "http://localhost:3000/addresses/new" }


    # Specify full Watir locator inside block
    # element(:foo) { browser.div(id: 'foo') }

    element(:first_name) {  }
    element(:last_name) {  }
    element(:street_address) {  }
    element(:secondary_address) {  }
    element(:city) {  }
    element(:state) {  }
    element(:zip_code) {  }
    element(:submit) { browser.button(visible: true) }

    def submit_form(address = nil)
      address ||= AddressBook::Data::Address.new
      fill_form(address)
      submit.click
      address
    end

  end
end
