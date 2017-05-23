module AddressBook::Address
  class Show < AddressBook::Base

    page_url { |address| "http://localhost:3000/addresses/#{address.id}" }


    element(:list, required: true) { browser.a(data_test: 'list') }
    element(:edit) { browser.a(data_test: 'edit') }
    element(:notice) { browser.div(data_test: 'notice') }
    element(:first_name) { browser.span(data_test: 'first_name') }
    element(:last_name) { browser.span(data_test: 'last_name') }
    element(:street_address) { browser.span(data_test: 'street_address') }
    element(:secondary_address) { browser.span(data_test: 'secondary_address') }
    element(:city) { browser.span(data_test: 'city') }
    element(:state) { browser.span(data_test: 'state') }
    element(:zip_code) { browser.span(data_test: 'zip_code') }

    def follow_list
      list.click
    end

    def follow_edit
      edit.click
    end

    def updated_message?
      notice.text == "Address was successfully updated."
    end

    def created_message?
      notice.text == "Address was successfully created."
    end

    def address?(address)
      on_page? && address == to_address
    end

    def to_address
      parsed = AddressBook::Data::Address.keys.each_with_object({}) do |sym, hash|
        hash[sym] = send(sym).text
      end
      AddressBook::Data::Address.new parsed
    end

  end
end
