module AddressBook
  class API::Base < UI2API::Base

    def self.headers
      super.merge(cookies: auth_cookies)
    end

    def self.auth_cookies
      if Site::AddressBook.user.nil?
        cookies = Site::AddressBook.browser.cookies.to_a
        rt = cookies.find { |cookie| cookie[:name] == "remember_token" }
        abs = cookies.find { |cookie| cookie[:name] == "_address_book_session" }
        c = {}
        c[:remember_token] = rt[:value] unless rt.nil?
        c[:address_book_session] = abs[:value] unless abs.nil?
        c
      else
        {remember_token: Site::AddressBook.user.remember_token,
         address_book_session: Site::AddressBook.user.address_book_session}
      end
    end

  end
end
