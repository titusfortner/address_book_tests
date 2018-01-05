module AddressBook
  module Page
    class SignUp < Base

      page_url { "#{base_url}/sign_up" }

      element(:email_address) { browser.text_field(id: "user_email") }
      element(:password) { browser.text_field(id: "user_password") }
      element(:submit) { browser.button(visible: true) }

      def submit_form(user = nil)
        user ||= Model::User.new
        fill_form(user)
        submit.click
        user
      end

    end
  end
end
