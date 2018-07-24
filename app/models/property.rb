class Property < ApplicationRecord

  PRICE_COMPARISSON_RADIUS_IN_METER = 5000

  acts_as_geolocated

  scope :with_offer_type, -> (offer_type){
    where(offer_type: offer_type)
  }

  scope :with_property_type, -> (property_type){
    where(property_type: property_type)
  }

end
