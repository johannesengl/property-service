require 'rails_helper'

RSpec.describe PropertySearchValidation do

  let(:property_search_validation) { PropertySearchValidation.new }

  context "when params are empty" do

    it 'should be valid' do
      expect(property_search_validation.valid?).to be(true)
    end

  end

  context "when params are valid" do
    let(:property_search_validation) { PropertySearchValidation.new({lat: 10.1, lng: 10.1, marketing_type: 'rent'}) }
    it 'should be valid' do
      expect(property_search_validation.valid?).to be(true)
    end
  end

  context "when lat is not nummeric" do

    let(:property_search_validation) { PropertySearchValidation.new({lat: 'hello', lng: 10.1}) }

    it 'should not be valid' do
      expect(property_search_validation.valid?).to be(false)
    end

    it 'should add the corresponding error to the object' do
      property_search_validation.valid?
      expect(property_search_validation.errors.messages).to eq({:lat=>["is not a number"]})
    end

  end

  context "when lat is present and lng is blank" do

    let(:property_search_validation) { PropertySearchValidation.new({lat: 10.1}) }

    it 'should not be valid' do
      expect(property_search_validation.valid?).to be(false)
    end

    it 'should add the corresponding error to the object' do
      property_search_validation.valid?
      expect(property_search_validation.errors.messages).to eq({:lng=>["can't be blank", "is not a number"]})
    end

  end

  context "when marketing_type is unknown type" do

    let(:property_search_validation) { PropertySearchValidation.new({marketing_type: 'test'}) }

    it 'should not be valid' do
      expect(property_search_validation.valid?).to be(false)
    end

    it 'should add the corresponding error to the object' do
      property_search_validation.valid?
      expect(property_search_validation.errors.messages).to eq({:marketing_type=>["is not included in the list"]})
    end

  end



end
