module AddressBook
  module Data
    class User < Base

      key(:email_address) { Defaults.translate :email_address }
      key(:password) { Defaults.translate :password }
          
    end
  end
end
