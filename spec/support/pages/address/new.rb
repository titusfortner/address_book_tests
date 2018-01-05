module AddressBook
  module Page
    class AddressNew < Base

      page_url { "#{base_url}/addresses/new" }

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
