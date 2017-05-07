class AddressBook

  def browser
    WatirDrops::PageObject.browser
  end

  def create_user(user = nil)
    user = log_in_user(user)
    NavBar.new.sign_out_user
    user
  end

  def log_in_user(user = nil)
    SignUp.visit.submit_form(user)
  end

  def address_present?(address)
    AddressList.visit.present?(address)
  end

  def create_address(address = nil)
    address ||= Address.new
    NewAddress.visit.submit_form(address)
  end

end