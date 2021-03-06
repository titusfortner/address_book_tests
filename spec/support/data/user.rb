module AddressBook
  module Model
    class User < Base

      key(:email_address, api: :email) { Faker::Internet.email }
      key(:password) { Faker::Internet.password }
          
    end
  end
end
