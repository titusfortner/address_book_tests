require 'faker'

module AddressBook
  module API
    class Base < WatirApi::Base
      class << self
        def headers
          super.merge(cookies: site_cookies)
        end

        def site_cookies
          cookies = Site.browser.cookies.to_a
          rt = cookies.find { |cookie| cookie[:name] == "remember_token" }
          abs = cookies.find { |cookie| cookie[:name] == "_address_book_session" }
          c = {}
          c[:remember_token] = rt[:value] unless rt.nil?
          c[:address_book_session] = abs[:value] unless abs.nil?
          c
        end
      end
    end
  end
end
