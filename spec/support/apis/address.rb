module AddressBook
  module API
    class Address < Base

      class << self
        def endpoint
          'addresses'
        end
      end

    end
  end
end
