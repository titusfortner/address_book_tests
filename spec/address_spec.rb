require 'spec_helper'

describe AddressBook do
  let(:address) { AddressBook::Data::Address.new }

  it 'creates' do
    SignUp.visit.submit_form
    Address::New.visit.submit_form(address)
    expect(Address::Show.new.created_message?).to eq true
    expect(Address::List.visit.present?(address)).to eq true
  end

  it 'shows' do
    SignUp.visit.submit_form
    Address::New.visit.submit_form(address)
    expect(Address::Show.new.address?(address)).to eq true
  end

  it 'lists' do
    SignUp.visit.submit_form
    Address::New.visit.submit_form(address)
    expect(Address::List.visit.present?(address)).to eq true
  end

  it 'edits' do
    SignUp.visit.submit_form
    Address::New.visit.submit_form(address)
    Address::Show.new.follow_edit
    edited_address = Address::Edit.new.submit_form
    expect(Address::Show.new.updated_message?).to eq true
    expect(Address::Show.new.address?(edited_address)).to eq true
  end

  it 'deletes' do
    SignUp.visit.submit_form
    Address::New.visit.submit_form(address)
    Address::List.visit.destroy(address)
    expect(Address::List.new.destroyed_message?).to eq true
    expect(Address::List.new.present?(address)).to eq false
  end

end
