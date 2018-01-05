module AddressBook
  module Site
    class AddressBook

      class << self
        attr_accessor :base_url, :browser, :user
      end

      def base_url
        self.class.base_url
      end

      def browser
        self.class.browser
      end

      def create_user(user = nil)
        @user = API::User.create(user)
      end

      def login_user(user = nil)
        Page::Home.visit
        create_user(user)
        browser.cookies.add 'remember_token', @user.remember_token
        browser.refresh
      end

      def logged_in?(user)
        found_user = API::User.show
        return false if found_user.data.nil?
        found_user.data[:email] == user.email_address
      end

      def create_address(address = nil)
        API::Address.create(address)
      end

      def address?(address)
        API::Address.index.addresses.include? address
      end
    end
  end
end
