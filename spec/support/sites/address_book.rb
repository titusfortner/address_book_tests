module AddressBook
  module Site
    class AddressBook

      class << self
        attr_accessor :base_url, :browser
      end

      def base_url
        self.class.base_url
      end

      def browser
        self.class.browser
      end

      def create_user(user = nil)

      end

      def create_address(address = nil)

      end

      def address?(address)

      end

    end
  end
end
