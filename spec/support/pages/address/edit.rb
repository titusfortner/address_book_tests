module AddressBook::Address
  class Edit < AddressBook::Base

    page_url { |address| "http://localhost:3000/addresses/#{address.id}/edit" }

    element(:first_name) { browser.text_field(id: 'address_first_name') }
    element(:last_name) { browser.text_field(id: 'address_last_name') }
    element(:street_address) { browser.text_field(id: 'address_street_address') }
    element(:secondary_address) { browser.text_field(id: 'address_secondary_address') }
    element(:city) { browser.text_field(id: 'address_city') }
    element(:state) { browser.text_field(id: 'address_state') }
    element(:zip_code) { browser.text_field(id: 'address_zip_code') }
    element(:submit) { browser.button(visible: true) }

    def submit_form(address = nil)
      address ||= AddressBook::Data::Address.new
      fill_form(address)
      submit.click
      address
    end

  end
end