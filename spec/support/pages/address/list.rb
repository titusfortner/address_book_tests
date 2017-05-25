module AddressBook
  class AddressList < Page::Base

    page_url { "#{Site.base_url}/addresses" }


    element(:create) { browser.a(data_test: 'create') }
    elements(:addresses) { browser.tbody.wait_until(&:present?).trs }
    element(:show) { |index = 0| browser.td(text: 'Show', index: index) }
    element(:edit) { |index = 0| browser.td(text: 'Edit', index: index) }
    element(:delete) { |index = 0| browser.td(text: 'Destroy', index: index) }
    element(:notice) { browser.div(data_test: 'notice') }

    def follow_new_address
      create.click
    end

    def number_addresses
      addresses.size
    end

    def follow_edit(address)
      index = address_index(address)
      edit(index).click
    end

    def destroy(address)
      index = address_index(address)
      raise StandardError, "Address not found: #{address.inspect}" if index.nil?
      delete(index).click
      browser.alert.ok
    end

    def address?(address)
      !address_index(address).nil?
    end

    def destroyed_message?
      notice.text == "Address was successfully destroyed."
    end

    private

    def address_index(address)
      addresses.find_index do |display|
        display.text.include?(address.first_name) && display.text.include?(address.last_name)
      end
    end

  end
end
