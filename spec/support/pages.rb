module AddressBook
  class Page::Base < WatirDrops::PageObject

    def self.base_url
      Site::AddressBook.base_url
    end

    def goto(*args)
      browser.goto page_url(*args)
    rescue StandardError => ex
      raise ex, "Unable to navigate, you might need to change the `page_url` or create a custom `#{self.class}#goto` method: #{ex.message}"
    end

  end
end
