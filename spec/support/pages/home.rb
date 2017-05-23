module AddressBook
  class Home < AddressBook::Base

    page_url { "http://localhost:3000" }


    element(:current_user) { browser.span(data_test: 'current-user') }
    element(:logout) { browser.a(data_test: 'sign-out') }

    def logged_in?
      current_user.present?
    end

    def signed_in_user
      current_user.text
    end

    def sign_out_user
      logout.click
    end

  end
end
