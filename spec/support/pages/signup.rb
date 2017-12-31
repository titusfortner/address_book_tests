module AddressBook
  class SignUp < AddressBook::Base

    page_url { "#{Site.base_url}/sign_up" }


    element(:email_address) { browser.text_field(id: "user_email") }
    element(:password) { browser.text_field(id: "user_password") }
    element(:submit) { browser.button(visible: true) }

    def submit_form(user = nil)
      user ||= AddressBook::Model::User.new
      fill_form(user)
      submit.click
      user
    end

  end
end
