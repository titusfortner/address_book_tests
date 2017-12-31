require 'rest-client'

module AddressBook
  class Site

    class << self
      def base_url=(base_url)
        @@base_url = base_url
      end

      def base_url
        @@base_url
      end

      def browser=(browser)
        @@browser = browser
      end

      def browser
        @@browser
      end
    end

    def base_url
      @@base_url
    end

    def browser
      @@browser
    end

    def create_user(user = nil)
      API::User.create(user)
    end

    def login(user = nil)
      Home.visit
      user = create_user(user)
      browser.cookies.add 'remember_token', user.remember_token
    end

    def logged_in?(user)
      found_user = API::User.show
      return false if found_user.remember_token.nil?
      found_user.data[:email] == user.email_address
    end

    def address?(address)
      index = API::Address.index
      addresses = JSON.parse(index.body)
      addresses.any? { |h| Model::Address.convert(h) == address }
    end

    def create_address(address = nil)
      API::Address.create(address)
    end
  end
end
