module AddressBook
  module Model
    class Config < ::ConfigModel

      key(:base_url) { "" }
      key(:use_sauce, data_type: :boolean) { false }
          
    end
  end
end
