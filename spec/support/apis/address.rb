module AddressBook
  module API
    class Address < Base
      class << self
        def endpoint
          'addresses'
        end

        def create(address = nil)
          address ||= Data::Address.new

          payload = address.to_hash
          payload[:address1] = payload.delete(:street_address)
          payload[:address2] = payload.delete(:secondary_address)

          result = super(payload: payload.to_json)
          id = JSON.parse(result.body)['id']
          new(address, id: id)
        end
      end

      attr_accessor :address, :id

      def initialize(address = nil, id: nil)
        @address = address
        @id = id
      end
    end
  end
end
