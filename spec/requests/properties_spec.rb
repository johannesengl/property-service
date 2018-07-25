require 'rails_helper'

RSpec.describe "Property API" do


  # Origin: Lat: 52.5342963 Lng: 13.4236807

  # Latitude: 52°30′03″N   52.50077829
  # Longitude: 13°18′04″E   13.3010584
  # Distance: 9.0983 km  Bearing: 245.859°

  # Latitude: 52°32′23″N   52.53974094
  # Longitude: 13°27′58″E   13.46617953
  # Distance: 2.9383 km  Bearing: 78.089°

  # Latitude: 52°33′27″N   52.55763538
  # Longitude: 13°23′59″E   13.39981618
  # Distance: 3.0569 km  Bearing: 328.135°

  let(:origin){[52.5342963, 13.4236807]}

  let(:properties) {[
    FactoryBot.create(:property, lat: 52.50077829, lng: 13.3010584),
    FactoryBot.create(:property, lat: 52.53974094, lng: 13.46617953),
    FactoryBot.create(:property, lat: 52.55763538, lng: 13.39981618)
  ]}

  it 'it retrieves json of all properties if no params given' do
    properties = FactoryBot.create_list(:property, 5)
    get ""
    expect(response).to be_success
    expect(JSON.parse(response.body).count).to be(5)
  end

  it 'it retrieves returns 404 if no properties found' do
    json_response = {"error"=>"No data for given parameters", "status"=>"404"}
    get ""
    expect(response).to be_success
    expect(JSON.parse(response.body)).to eq(json_response)
  end

  it 'it retrieves json of the two properties within five km radius of a given location' do
    properties

    json_response = [
      {"zip_code"=>"12345", "city"=>"Berlin", "street"=>"Berlinerstraße", "house_number"=>"4a", "lng"=>"13.46617953", "lat"=>"52.53974094", "price"=>"300000.0"},
      {"zip_code"=>"12345", "city"=>"Berlin", "street"=>"Berlinerstraße", "house_number"=>"4a", "lng"=>"13.39981618", "lat"=>"52.55763538", "price"=>"300000.0"}
    ]

    get "?lat=#{origin[0]}&lng=#{origin[1]}"
    expect(response).to be_success
    expect(JSON.parse(response.body)).to eq(json_response)
  end

  it 'it retrieves json of the properties by offer type / marketing_type' do
    properties = FactoryBot.create_list(:property, 2)
    properties[0].update(offer_type: 'rent', street: 'rent-street')
    properties[1].update(offer_type: 'sell', street: 'sell-street')

    json_response = [
      {"zip_code"=>"12345", "city"=>"Berlin", "street"=>"rent-street", "house_number"=>"4a", "lng"=>"0.0", "lat"=>"0.0", "price"=>"300000.0"},
    ]

    get "?marketing_type=rent"
    expect(response).to be_success
    expect(JSON.parse(response.body)).to eq(json_response)
  end

  it 'it retrieves returns 500 if params are invalid' do
    json_response = {"error"=>"Lng can't be blank, Lng is not a number", "status"=>"500"}
    get "?lat=#{origin[0]}"
    expect(response).to be_success
    expect(JSON.parse(response.body)).to eq(json_response)
  end

end
