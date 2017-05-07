require "spec_helper"

describe "Test in Series" do

  it 'uses watir drops' do
    Home.visit.sign_in_link
    SignIn.new.sign_up_link
    user = User.new
    SignUp.new.submit_form(user)
    expect(NavBar.new.signed_in_user).to eq user.email

    NavBar.new.sign_out_user
    expect(NavBar.new.logged_in?).to eq false

    SignIn.new.submit_form(user)
    expect(NavBar.new.logged_in?).to eq true

    NavBar.new.addresses_link
    AddressList.new.new_address_link
    address = NewAddress.new.submit_form
    expect(AddressShow.new.created_message?).to eq true
    expect(AddressShow.new.address?(address)).to eq true

    AddressShow.new.follow_list
    expect(AddressList.new.number_addresses).to eq 1
    expect(AddressList.new.present?(address)).to eq true

    AddressList.new.follow_edit(address)
    edited_address = EditAddress.new.submit_form
    expect(AddressShow.new.updated_message?).to eq true
    expect(AddressShow.new.address?(edited_address)).to eq true

    AddressShow.new.follow_list
    AddressList.new.destroy(edited_address)
    expect(AddressList.new.destroyed_message?).to eq true
    expect(AddressList.new.present?(address)).to eq false
  end

end
