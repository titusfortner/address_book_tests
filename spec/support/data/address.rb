module AddressBook
  module Model
    class Address < Base

      key(:first_name) {  }
      key(:last_name) {  }
      key(:street_address) {  }
      key(:secondary_address) {  }
      key(:city) { }
      key(:state) {  }
      key(:zip_code) {  }

    end
  end
end
