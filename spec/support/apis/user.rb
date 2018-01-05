module AddressBook
  module API
    class User < Base

      class << self
        def endpoint
          'users'
        end

      end
    end
  end
end
