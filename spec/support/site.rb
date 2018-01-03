module AddressBook
  class Site

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
      API::User.create(user)
    end

    def login(user = nil)
      Page::Home.visit
      user = create_user(user)
      browser.cookies.add 'remember_token', user.remember_token
    end

    def logged_in?(user)
      found_user = API::User.show
      return false if found_user.data.nil?
      found_user.data[:email] == user.email_address
    end

    def address?(address)
      API::Address.index.addresses.include? address
    end

    def create_address(address = nil)
      API::Address.create(address)
    end
  end
end
