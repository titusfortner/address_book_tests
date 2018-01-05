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
      login_user(user)
      Page::Home.new.logout_user
    end

    def login_user(user = nil)
      Page::SignUp.visit.submit_form(user)
    end

    def logged_in?(user)
      Page::Home.new.signed_in_user == user.email_address
    end

    def create_address(address = nil)
      Page::AddressNew.visit.submit_form(address)
    end

    def address?(address)
      return false unless Page::AddressList.visit.address?(address)
      Page::AddressShow.visit(address).address?(address)
    end
  end
end
