require 'spec_helper'

module AddressBook
  describe AddressBook do
    let(:address) { Data::Address.new }

    it 'creates' do
      SignUp.visit.submit_form

      AddressNew.visit.submit_form(address)

      expect(AddressShow.new.created_message?).to eq true
      expect(AddressShow.new.address?(address)).to eq true
    end

    it 'shows' do
      SignUp.visit.submit_form

      AddressNew.visit.submit_form(address)

      expect(AddressShow.new.address?(address)).to eq true
    end

    it 'lists' do
      SignUp.visit.submit_form
      AddressNew.visit.submit_form(address)
      address2 = AddressNew.visit.submit_form

      expect(AddressList.visit.address?(address)).to eq true
      expect(AddressList.visit.address?(address2)).to eq true
    end

    it 'edits' do
      SignUp.visit.submit_form
      AddressNew.visit.submit_form(address)
      AddressShow.new.update_address(address)

      edited_address = AddressEdit.visit(address).submit_form

      expect(AddressShow.new.updated_message?).to eq true
      expect(AddressShow.new.address?(edited_address)).to eq true
    end

    it 'deletes' do
      SignUp.visit.submit_form
      AddressNew.visit.submit_form(address)

      AddressList.visit.destroy(address)

      expect(AddressList.new.destroyed_message?).to eq true
      expect(AddressList.new.address?(address)).to eq false
    end

  end
end