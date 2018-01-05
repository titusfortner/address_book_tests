require 'spec_helper'

module AddressBook
  include Page

  describe "Addresses" do

    let(:address) { Model::Address.new }
    let(:address_book) { Site::AddressBook.new }

    it 'creates' do
      AddressNew.visit.submit_form(address)

      expect(address_book.address?(address)).to eq true
    end

    it 'shows' do
      address_book.create_address(address)

      expect(AddressShow.visit(address).address?(address)).to eq true
    end

    it 'lists' do
      address_book.create_address(address)

      expect(AddressList.visit.address?(address)).to eq true
    end

    it 'edits' do
      address_book.create_address(address)
      edited_address = Model::Address.new

      AddressEdit.visit(address).submit_form(edited_address)

      expect(address_book.address?(edited_address)).to eq true
    end

    it 'deletes' do
      address_book.create_address(address)

      AddressList.visit.destroy(address)

      expect(address_book.address?(address)).to eq false
    end

  end
end
