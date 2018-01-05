require 'spec_helper'

module AddressBook
  include Page

  describe "Addresses" do

    let(:address) { Model::Address.new }
    let(:site) { Site.new }

    before do
      site.login_user
    end

    it 'creates' do
      AddressNew.visit.submit_form(address)

      expect(AddressShow.new.created_message?).to eq true
      expect(site.address?(address)).to eq true
    end

    it 'shows' do
      site.create_address(address)

      expect(AddressShow.visit(address).address?(address)).to eq true
    end

    it 'lists' do
      site.create_address(address)

      expect(AddressList.visit.address?(address)).to eq true
    end

    it 'edits' do
      site.create_address(address)
      edited_address = Model::Address.new

      AddressEdit.visit(address).submit_form(edited_address)

      expect(AddressShow.new.updated_message?).to eq true
      expect(site.address?(edited_address)).to eq true
    end

    it 'deletes' do
      site.create_address(address)

      AddressList.visit.destroy(address)

      expect(AddressList.new.destroyed_message?).to eq true
      expect(site.address?(address)).to eq false
    end

  end
end
