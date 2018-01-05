require 'spec_helper'

module AddressBook
  include Page

  describe "User" do

    let(:user) { Model::User.new }
    let(:address_book) { Site::AddressBook.new }

    it 'signs up' do
      SignUp.visit.submit_form(user)

      expect(address_book.logged_in?(user)).to eq true
    end

    it 'login' do
      address_book.create_user(user)

      SignIn.visit.submit_form(user)

      expect(address_book.logged_in?(user)).to eq true
    end

    it 'logout' do
      address_book.login_user(user)

      Home.new.logout_user

      expect(address_book.logged_in?(user)).to eq false
    end
  end
end
