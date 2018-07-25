class PropertiesController < ApplicationController

  before_action :validate_params

  def index
    @properties = build_query.all

    if @properties.empty?
      render json: {error: "No data for given parameters", status: "404"} and return
    else
      render json: @properties.to_json(:only => [ :house_number, :street, :city, :zip_code, :lat, :lng, :price ])
    end
  end

  protected

  def property_params
    params.permit(:lng, :lat, :property_type, :marketing_type)
  end

  def build_query
    query = Property
    query = query.within_radius(Property::PRICE_COMPARISSON_RADIUS_IN_METER, property_params[:lat], property_params[:lng]) if property_params[:lat] && property_params[:lng]
    query = query.with_offer_type(property_params[:marketing_type]) if property_params[:marketing_type]
    query = query.with_property_type(property_params[:property_type]) if property_params[:property_type]
    query
  end

  def validate_params
    v = PropertySearchValidation.new(property_params)
    unless v.valid?
      render json: {error: v.errors.full_messages.join(', '), status: "500"} and return
    end
  end

end
