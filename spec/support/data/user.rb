module AddressBook
  module Data
    class User < Base

      # Specify default data for each key inside block

      key(:email_address) { Defaults.translate :email_address }
      key(:password) { Defaults.translate :password }

    end
  end
end
