module AddressBook
  class Site::Base

    class << self
      attr_accessor :base_url, :browser
    end

    def base_url
      self.class.base_url
    end

    def browser
      self.class.browser
    end

  end
end
