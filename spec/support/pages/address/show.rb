module AddressBook
  module Page
    class AddressShow < Base

      page_url { |address| "#{base_url}/addresses/#{address.id}" }

    end
  end
end