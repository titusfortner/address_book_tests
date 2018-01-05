module AddressBook
  module Page
    class AddressList < Base

      page_url { "#{Site.base_url}/addresses" }

      element(:create) { browser.a(data_test: 'create') }
      elements(:addresses) { browser.tbody.wait_until(&:present?).trs }
      element(:show_link) { |index = 0| browser.a(text: 'Show', index: index) }
      element(:edit_link) { |index = 0| browser.a(text: 'Edit', index: index) }
      element(:delete_link) { |index = 0| browser.a(text: 'Destroy', index: index) }
      element(:notice) { browser.div(data_test: 'notice') }

      def new_address
        create_link.click
      end

      def edit(address)
        index = address_index(address)
        edit_link(index).click
      end

      def show(address)
        index = address_index(address)
        sl = show_link(index)
            sl.click
      end

      def address?(address)
        !address_index(address).nil?
      end

      def destroy(address)
        index = address_index(address)
        raise StandardError, "Address not found: #{address.inspect}" if index.nil?
        delete_link(index).click
        browser.alert.ok
      end

      def present?(address)
        !address_index(address).nil?
      end

      def destroyed_message?
        notice.text == "Address was successfully destroyed."
      end

      private

      def address_index(address)
        addresses.find_index do |display|
          text = display.text
          text.include?(address.first_name) && text.include?(address.last_name)
        end
      end

    end
  end
end
