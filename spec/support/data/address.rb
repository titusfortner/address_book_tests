module AddressBook
  module Data
    class Address < Base

      key(:first_name) { Defaults.translate :first_name }
      key(:last_name) { Defaults.translate :last_name }
      key(:street_address) { Defaults.translate :street_address }
      key(:secondary_address) { Defaults.translate :secondary_address }
      key(:city) { Defaults.translate :city }
      key(:state) { Defaults.translate :state }
      key(:zip_code) { Defaults.translate :zip_code }

    end
  end
end
