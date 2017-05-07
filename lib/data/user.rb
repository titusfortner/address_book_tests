require 'faker'

class User < BaseModel
  key(:email) { Faker::Internet.email }
  key(:password) { Faker::Internet.password }
end