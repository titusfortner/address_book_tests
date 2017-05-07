class Home < WatirDrops::PageObject

  page_url { "https://address-book-example.herokuapp.com" }

  element(:sign_in) { browser.a(data_test: 'sign-in') }

  def sign_in_link
    sign_in.click
  end

end


