require 'spec_helper'

module AddressBook
  describe Data::User do

    let(:user) { Data::User.new }


    it 'signup' do
      SignUp.visit.submit_form(user)

      expect(Home.visit.signed_in_user).to eq user.email_address
    end

    it 'login' do
      SignUp.visit.submit_form(user)
      Home.new.sign_out_user

      SignIn.visit.submit_form(user)

      expect(Home.new.logged_in?).to eq true
    end

    it 'logout' do
      SignUp.visit.submit_form(user)

      Home.new.sign_out_user

      expect(Home.new.logged_in?).to eq false
    end
  end
end
