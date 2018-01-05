module AddressBook
  class Page::Base < WatirDrops::PageObject

    def self.base_url
      Site::AddressBook.base_url
    end

    def goto(*args)
      browser.goto page_url(*args)
    rescue StandardError => ex
      goto_subclass = methods(false).include?(:goto)
      ui2api = Gem::Specification.any? { |gem| gem.name == 'ui2api' }
      msg = "Unable to navigate to this page, you might need to change the `page_url`\n"
      if ex.is_a?(NoMethodError) && ex.message.include?('id') && args.first.is_a?(WatirModel)
        msg << "Models typically do not include an id, while API return values typically do\n"
        msg << "If you are making use of the UI2API gem, you may need to pass in the API object instead\n" if ui2api
      end
      msg << "Alternately, you might need to create a custom `#{self.class}#goto` method\n" unless goto_subclass

      raise ex, "#{msg} #{ex.message}"
    end

  end
end
