require 'faker'

FactoryBot.define do
  factory :property do
    name Faker::Name.name
    address  Faker::Address.street_address 
    no_of_bedrooms Faker::Number.digit
    no_of_bathrooms Faker::Number.digit
    size Faker::Number.decimal(2)
    latitude Faker::Address.latitude
    longitude Faker::Address.longitude
  end
end