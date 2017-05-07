require "spec_helper"

describe "Test in Parallel" do

  let(:browser) { @browser }
  let(:sign_in_page) { SignIn.new }
  let(:sign_up_page) { SignUp.new }
  let(:nav_bar) { NavBar.new }
  let(:address_list_page) { AddressList.new }
  let(:new_address_page) { NewAddress.new }
  let(:show_address_page) { AddressShow.new }
  let(:address_book_site) { AddressBook.new }

  it 'signs up' do
    Home.visit.sign_in_link
    sign_in_page.sign_up_link
    user = User.new
    sign_up_page.submit_form(user)
    expect(nav_bar.signed_in_user).to eq user.email
  end

  it 'signs out' do
    address_book_site.log_in_user
    nav_bar.sign_out_user
    expect(nav_bar.logged_in?).to eq false
  end

  it 'signs in' do
    user = address_book_site.create_user
    SignIn.visit.submit_form(user)
    expect(nav_bar.logged_in?).to eq true
  end

  it 'creates address' do
    address_book_site.log_in_user
    address = NewAddress.visit.submit_form
    expect(show_address_page.created_message?).to eq true
    expect(address_book_site.address_present?(address)).to eq true
  end

  it 'displays specific address' do
    address_book_site.log_in_user
    address = address_book_site.create_address
    expect(show_address_page.address?(address)).to eq true
  end

  it 'displays address list' do
    address_book_site.log_in_user
    address = address_book_site.create_address
    expect(AddressList.visit.present?(address)).to eq true
  end

  it 'edits address' do
    address_book_site.log_in_user
    address = address_book_site.create_address
    edited_address = EditAddress.visit(address).submit_form
    expect(show_address_page.updated_message?).to eq true
    expect(address_book_site.address_present?(edited_address)).to eq true
  end

  it 'deletes address' do
    address_book_site.log_in_user
    address = address_book_site.create_address
    AddressList.visit.destroy(address)
    expect(address_list_page.destroyed_message?).to eq true
    expect(address_book_site.address_present?(address)).to eq false
  end

end
