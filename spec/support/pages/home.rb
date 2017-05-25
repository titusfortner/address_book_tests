module AddressBook
  class Home < Page::Base

    page_url { "#{Site.base_url}/" }


    element(:current_user) { browser.span(data_test: 'current-user') }
    element(:logout) { browser.a(data_test: 'sign-out') }
    element(:sign_in) { browser.a(data_test: 'sign-in') }
    element(:addresses) { browser.a(data_test: 'addresses') }


    def signed_in_user
      return nil if sign_in.present?
      current_user.text
    end

    def sign_out_user
      logout.click
    end

    def logged_in?
      current_user.present?
    end

  end
end
