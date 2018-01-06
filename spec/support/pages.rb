module AddressBook
  module Page
    class Base < WatirDrops::PageObject

    def self.base_url
      Site::AddressBook.base_url
    end

    end
  end
end
