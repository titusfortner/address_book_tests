module AddressBook
  module Page
    class AddressEdit < Base

      page_url { |address| "#{base_url}/addresses/#{address.id}/edit" }

      element(:first_name) {  }
      element(:last_name) {  }
      element(:street_address) {  }
      element(:secondary_address) {  }
      element(:city) {  }
      element(:state) {  }
      element(:zip_code) {  }
      element(:submit) {  }

    end
  end
end