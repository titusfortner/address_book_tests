module AddressBook
  module Model
    class SauceCredentials < ::ConfigModel

      key(:sauce_username) { } # Do not store credentials in source control
      key(:sauce_access_key) { } # Do not store credentials in source control

    end
  end
end
