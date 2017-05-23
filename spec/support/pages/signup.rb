module AddressBook
  class SignUp < AddressBook::Base

    page_url { "http://localhost:3000/sign_up" }


    # Specify full Watir locator inside block
    # element(:foo) { browser.div(id: 'foo') }

    element(:email_address) {  }
    element(:password) {  }
    element(:submit) { browser.button(visible: true) }

    def submit_form(user = nil)
      user ||= AddressBook::Data::User.new
      fill_form(user)
      submit.click
      user
    end

  end
end
