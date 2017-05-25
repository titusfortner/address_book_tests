require 'faker'
require 'data_magic/standard_translation'

module AddressBook
  module Data
    class Base < WatirModel

      attr_accessor :id

    end

    class Defaults
      include DataMagic::StandardTranslation

      def self.translate(key)
        return new.send(:characters, 10) if key == :password
        new.send(key)
      end
    end
  end
end
