module AddressBook
  class SignIn < AddressBook::Base

    page_url { "http://localhost:3000/sign_in" }


    element(:email_address) { browser.text_field(id: "session_email") }
    element(:password) { browser.text_field(id: "session_password") }
    element(:submit) { browser.button(visible: true) }

    def submit_form(user = nil)
      user ||= AddressBook::Data::User.new
      fill_form(user)
      submit.click
      user
    end

  end
end
