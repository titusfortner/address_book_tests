require 'faker'

module AddressBook
  module API
    class Base
      class << self

        def create(opt)
          opt[:method] = :post
          api_call(opt)
        end

        def index(opt = {})
          opt[:method] = :get
          api_call(opt)
        end

        def show(obj)
          opt = {method: :get,
                 url: "#{Site.base_url}/#{endpoint}/#{obj.id}"}
          api_call(opt)
        end

        def update(obj, payload)
          opt = {method: :put,
                 url: "#{Site.base_url}/#{endpoint}/#{obj.id}",
                 payload: payload}
          api_call(opt)
        end

        def destroy(obj)
          opt = {method: :delete,
                 url: "#{Site.base_url}/#{endpoint}/#{obj.id}"}
          api_call(opt)
        end

        private

        def headers
          cookies = Site.browser.cookies.to_a
          remember_token = cookies.find { |cookie| cookie[:name] == "remember_token" }
          opt = {"Content-Type" => "application/json"}
          return opt if remember_token.nil?
          remember = remember_token[:value]
          session_cookie = cookies.find { |cookie| cookie[:name] == "_address_book_session" }
          session = session_cookie.nil? ? '' : session_cookie[:value]
          opt['Cookie'] = "remember_token=#{remember}; address_book_session=#{session}"
          opt
        end

        def api_call(opt)
          call = {method: opt[:method]}
          call[:url] = opt[:url] || "#{Site.base_url}/#{endpoint}"
          call[:verify_ssl] = opt[:ssl] if opt.key?(:ssl)
          call[:payload] = opt[:payload] if opt[:payload]
          call[:headers] = opt[:headers] || headers
          RestClient::Request.execute(call) do |_resp, _req, result|
            result
          end
        end
      end
    end
  end
end
