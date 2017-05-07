class NavBar < WatirDrops::PageObject

  element(:current_user) { browser.span(data_test: 'current-user') }
  element(:sign_out) { browser.a(data_test: 'sign-out') }
  element(:addresses) { browser.a(data_test: 'addresses') }

  def signed_in_user
    current_user.text
  end

  def sign_out_user
    sign_out.click
  end

  def logged_in?
    current_user.present?
  end

  def addresses_link
    addresses.click
  end

end
