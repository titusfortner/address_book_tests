module AddressBook
  class Site

    class << self
      def base_url=(base_url)
        @@base_url = base_url
      end

      def base_url
        @@base_url
      end
    end

  end
end
