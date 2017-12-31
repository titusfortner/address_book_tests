module AddressBook
  module API
    class User < API::Base
      class << self
        def endpoint
          'users'
        end

        def create(user = nil)
          created = super(user, headers: {content_type: :json})
          header = created.header
          created.remember_token = if header.key? :set_cookie
                                     c = header[:set_cookie].find { |cookie| cookie.match(/remember_token/) }
                                     c[/^remember_token=([^;]*)/, 1] unless c.nil?
                                   end
          created.address_book_session = if header.key? :set_cookie
                                           c = header[:set_cookie].find { |cookie| cookie.match(/address_book_session/) }
                                           c[/^_address_book_session=([^;]*)/, 1] unless c.nil?
                                         end
          Site.user = created
        end

        def show
          super(id: '', endpoint: 'current_user')
        end
      end

      attr_accessor :remember_token, :address_book_session

    end
  end
end
