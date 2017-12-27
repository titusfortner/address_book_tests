require 'spec_helper'

module AddressBook
  describe "Addresses" do

    let(:address) { Data::Address.new }
    let(:site) { Site.new }

    before { site.login }

    it 'creates' do
      AddressNew.visit.submit_form(address)

      expect(AddressShow.new.created_message?).to eq true
      expect(site.address?(address)).to eq true
    end

    it 'shows' do
      created_address = site.create_address(address)
      page = AddressShow.visit(created_address)
      expect(page.address?(address)).to eq true
    end

    it 'lists' do
      site.create_address(address)
      api_address = site.create_address

      expect(AddressList.visit.address?(address)).to eq true
      expect(AddressList.visit.address?(api_address.address)).to eq true
    end

    it 'edits' do
      address = site.create_address

      edited_address = AddressEdit.visit(address).submit_form

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
