class SignIn < WatirDrops::PageObject

  page_url { "https://address-book-example.herokuapp.com/sign_in" }

  element(:sign_up) { browser.a(data_test: 'sign-up') }
  element(:email) { browser.text_field(id: "session_email") }
  element(:password) { browser.text_field(id: "session_password") }
  element(:submit) { browser.button(data_test: 'submit') }

  def submit_form(user = nil)
    user ||= User.new
    fill_form(user)
    submit.click
  end

  def sign_up_link
    sign_up.click
  end

end


