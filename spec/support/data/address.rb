module AddressBook
  module Model
    class Address < Base

      key(:first_name) { Faker::Name.first_name }
      key(:last_name) { Faker::Name.last_name }
      key(:street_address, api: :address1) { Faker::Address.street_address }
      key(:secondary_address, api: :address2) { Faker::Address.secondary_address }
      key(:city) { Faker::Address.city }
      key(:state) { Faker::Address.state }
      key(:zip_code) { Faker::Address.zip }

      def ==(other)
        keys = self.keys.dup
        keys.delete(:state)
        state_name = send(:state)
        state_abbrev = Madison.get_abbrev(state_name)
        (other.state == state_name || other.state == state_abbrev) && keys.all? { |k| send(k) == other[k] }
      end
    end
  end
end
