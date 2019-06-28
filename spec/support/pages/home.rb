module AddressBook
  module Page
    class Home < Base

      page_url { base_url }

      element(:current_user) { browser.span(data_test: 'current-user') }
      element(:sign_out) { browser.a(data_test: 'sign-out') }
      element(:sign_in) { browser.a(data_test: 'sign-in') }
      element(:addresses) { browser.a(data_test: 'addresses') }

      def logged_in?(user)
        signed_in_user == user.email_address
      end

      def signed_in_user
        begin
          return nil if sign_in.present?
        # TODO: This is bad, figure it out
        rescue Selenium::WebDriver::Error::WebDriverError
          nil
        end
        current_user.text
      end

      def logout_user
        sign_out.click
      end
    end
  end
end
