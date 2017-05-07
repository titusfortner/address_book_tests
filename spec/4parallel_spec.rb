require "spec_helper"

describe "Test in Parallel" do

  it 'signs up' do
    Home.visit.sign_in_link
    SignIn.new.sign_up_link
    user = User.new
    SignUp.new.submit_form(user)
    expect(NavBar.new.signed_in_user).to eq user.email
  end

  it 'signs out' do
    AddressBook.new.log_in_user
    NavBar.new.sign_out_user
    expect(NavBar.new.logged_in?).to eq false
  end

  it 'signs in' do
    user = AddressBook.new.create_user
    SignIn.visit.submit_form(user)
    expect(NavBar.new.logged_in?).to eq true
  end

  it 'creates address' do
    AddressBook.new.log_in_user
    address = NewAddress.visit.submit_form
    expect(AddressShow.new.created_message?).to eq true
    expect(AddressBook.new.address_present?(address)).to eq true
  end

  it 'displays specific address' do
    AddressBook.new.log_in_user
    address = AddressBook.new.create_address
    expect(AddressShow.new.address?(address)).to eq true
  end

  it 'displays address list' do
    AddressBook.new.log_in_user
    address = AddressBook.new.create_address
    expect(AddressList.visit.present?(address)).to eq true
  end

  it 'edits address' do
    AddressBook.new.log_in_user
    address = AddressBook.new.create_address
    edited_address = EditAddress.visit(address).submit_form
    expect(AddressShow.new.updated_message?).to eq true
    expect(AddressBook.new.address_present?(edited_address)).to eq true
  end

  it 'deletes address' do
    AddressBook.new.log_in_user
    address = AddressBook.new.create_address
    AddressList.visit.destroy(address)
    expect(AddressList.new.destroyed_message?).to eq true
    expect(AddressBook.new.address_present?(address)).to eq false
  end

end
