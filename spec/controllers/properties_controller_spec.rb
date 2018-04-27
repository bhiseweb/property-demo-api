require 'rails_helper'

describe PropertiesController , :type => :controller do  

  context '#index' do 
    
    before do 
      4.times { |i| create(:property) }
    end

    it 'return response as success' do
      get :index
      expect(response).to be_success
    end

    it 'return all properties' do
      get :index
      expect(JSON.parse(response.body).count).to eq 4
    end
  end

  context 'create' do
    
    let :property { build :property }

    it 'return to be success if all requires values provided' do
      post :create, params:  { property: { name: property.name, address: property.address, 
        no_of_bathrooms: property.no_of_bathrooms, no_of_bedrooms: property.no_of_bedrooms, size: property.size }}
      expect(response).to be_success
    end

    it 'create new property' do
      expect(Property.count).to eq 0
      post :create, params:  { property: { name: property.name, address: property.address, 
        no_of_bathrooms: property.no_of_bathrooms, no_of_bedrooms: property.no_of_bedrooms, size: property.size }}
      expect(Property.count).to eq 1
    end

    it 'return validation error if name blank' do
      post :create, params:  { property: { name: "", address: property.address, 
        no_of_bathrooms: property.no_of_bathrooms, no_of_bedrooms: property.no_of_bedrooms, size: property.size }}
      expect(JSON.parse(response.body)['message']).to include "Name can't be blank"
    end

    it 'return validation error if address blank' do
      post :create, params:  { property: { name: property.name, address: "", 
        no_of_bathrooms: property.no_of_bathrooms, no_of_bedrooms: property.no_of_bedrooms, size: property.size }}
      expect(JSON.parse(response.body)['message']).to include "Address can't be blank"
    end

    it 'permit name, address, no_of_bedrooms, no_of_bathrooms, size' do
      params = { property: { name: property.name, address: property.address, 
        no_of_bathrooms: property.no_of_bathrooms, no_of_bedrooms: property.no_of_bedrooms, 
        size: property.size }}
      should permit(:name, :address, :no_of_bedrooms, :no_of_bathrooms, :size).
      for(:create, params: params).on(:property)
    end

  end

  context 'stats' do
    before do 
      4.times { |i| create(:property) }
    end

    it 'return to be success' do
      get :stats
      expect(response).to be_success
    end

    it 'return no_of_properties, average_size and markers keys' do
      get :stats
      expect(JSON.parse(response.body)).to include "no_of_properties", "average_size", "markers"
    end

    it 'return total property in no_of_properties' do
      get :stats
      expect(JSON.parse(response.body)["no_of_properties"]).to eq 4
    end
  end

end