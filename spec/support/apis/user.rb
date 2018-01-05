module AddressBook
  module API
    class User < Base

      class << self
        def endpoint
          'users'
        end

        def create(user = nil)
          created = super(user)
          header = created.header
          if header.key? :set_cookie
            rt = header[:set_cookie].find { |cookie| cookie.match(/remember_token/) }
            created.remember_token = rt[/^remember_token=([^;]*)/, 1] unless rt.nil?

            abs = header[:set_cookie].find { |cookie| cookie.match(/address_book_session/) }
            created.address_book_session = abs[/^_address_book_session=([^;]*)/, 1] unless abs.nil?
          end
          Site::AddressBook.user = created
        end

        def show
          super(id: '', endpoint: 'current_user')
        end
      end

      attr_accessor :remember_token, :address_book_session

    end
  end
end
