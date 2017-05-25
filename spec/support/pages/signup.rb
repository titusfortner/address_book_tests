module AddressBook
  class SignUp < Page::Base

    page_url { "#{Site.base_url}/sign_up" }


    # Specify full Watir locator inside block
    # element(:foo) { browser.div(id: 'foo') }

    element(:email_address) {  }
    element(:password) {  }
    element(:submit) { browser.button(visible: true) }

    def submit_form(user = nil)
      user ||= Data::User.new
      fill_form(user)
      submit.click
      user
    end

  end
end
