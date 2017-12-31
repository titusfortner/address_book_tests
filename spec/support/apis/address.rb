module AddressBook
  module API
    class Address < API::Base
      class << self
        def endpoint
          'addresses'
        end
      end
    end
  end
end
