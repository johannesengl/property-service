FactoryBot.define do
  factory :property do
    offer_type 'sell'
    property_type 'apartment'
    zip_code '12345'
    city 'Berlin'
    street 'Berlinerstraße'
    house_number '4a'
    lng 0.0
    lat 0.0
    number_of_rooms 2.5
    currency 'EUR'
    price 300000
  end
end
