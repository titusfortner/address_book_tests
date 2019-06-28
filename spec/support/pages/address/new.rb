module AddressBook
  module Page
    class AddressNew < Base

      page_url { "#{base_url}/addresses/new" }

      element(:first_name) { browser.text_field(id: 'address_first_name') }
      element(:last_name) { browser.text_field(id: 'address_last_name') }
      element(:street_address) { browser.text_field(id: 'address_street_address') }
      element(:secondary_address) { browser.text_field(id: 'address_secondary_address') }
      element(:city) { browser.text_field(id: 'address_city') }
      element(:state) { browser.select(id: 'address_state') }
      element(:zip_code) { browser.text_field(id: 'address_zip_code') }
      element(:submit) { browser.button(visible: true) }

      def submit_form(address = nil)
        address ||= AddressBook::Model::Address.new
        fill_form(address)
        submit.click
        address
      end

    end
  end
end
