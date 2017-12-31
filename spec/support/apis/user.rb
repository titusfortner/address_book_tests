module AddressBook
  module API
    class User < Base
      class << self
        def endpoint
          'users'
        end

        def create(user = nil)
          super(user, headers: {content_type: :json})
        end

        def show
          super(id: '', endpoint: 'current_user')
        end

        def headers
          opt = super
          cookie_opt = {}

          cookies = Site.browser.cookies.to_a
          session_cookie = cookies.find { |c| c[:name] == "_address_book_session" }
          session = session_cookie.nil? ? nil : session_cookie[:value]

          cookie_opt[:address_book_session] = session unless session.nil?

          remember_cookie = cookies.find { |cookie| cookie[:name] == "remember_token" }
          remember_token = remember_cookie.nil? ? nil : remember_cookie[:value]

          cookie_opt[:remember_token] = remember_token unless remember_token.nil?

          opt[:cookies] = cookie_opt
          opt
        end
      end


      attr_accessor :remember_token

      def initialize(args)
        super(args)
        token = if @header.key? :set_cookie
                   c = @header[:set_cookie].find { |cookie| cookie.match(/remember_token/) }
                   c[/^remember_token=([^;]*)/, 1] unless c.nil?
                 else
                   c = Site.browser.cookies.to_a.find { |cookie| cookie[:name] == "remember_token" }
                   c[:value] unless c.nil?
                 end

        @remember_token = token.nil? ? nil : token
      end
    end
  end
end
