require 'rest-client'

module AddressBook
  class Site

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
      SignUp.visit.submit_form(user)
    end

    def login(user = nil)
      create_user(user)
    end

    def logged_in?(user)
      Home.visit.signed_in_user == user.email_address
    end

    def address?(address)
      API::Address.index.addresses.include? address
    end

    def create_address(address = nil)
      API::Address.create(address)
    end
  end
end
