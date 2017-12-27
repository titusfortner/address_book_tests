module AddressBook
  module Data
    class User < Base

      key(:email_address) { Faker::Internet.email }
      key(:password) { Faker::Internet.password }
          
    end
  end
end
