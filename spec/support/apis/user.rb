module AddressBook
  module API
    class User < Base
      class << self
        def endpoint
          'users'
        end

        def create(user = nil)
          user ||= Data::User.new
          payload = {"user[email]" => user.email_address,
                     "user[password]" => user.password}

          result = super(payload: payload)
          header = result.instance_variable_get('@header')
          cookie = header['set-cookie'][1]
          remember_token = cookie[/^remember_token=([^;]*)/, 1]
          new(user, remember_token: remember_token)
        end

        def show
          opt = {method: :get,
                 url: "#{Site.base_url}/current_user"}
          api_call(opt)
        end
      end

      attr_accessor :user, :remember_token

      def initialize(user = nil, remember_token: nil)
        @user = user
        @remember_token = remember_token
      end
    end
  end
end
