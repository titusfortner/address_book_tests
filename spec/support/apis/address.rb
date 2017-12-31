module AddressBook
  module API
    class Address < Base
      class << self
        def endpoint
          'addresses'
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
