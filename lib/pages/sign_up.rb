class SignUp < WatirDrops::PageObject

  page_url { "https://address-book-example.herokuapp.com/sign_up" }

  element(:email) { browser.text_field(id: "user_email") }
  element(:password) { browser.text_field(id: "user_password") }
  element(:submit) { browser.button(data_test: 'submit') }

  def submit_form(user = nil)
    user ||= User.new
    fill_form(user)
    submit.click
    user
  end
end


