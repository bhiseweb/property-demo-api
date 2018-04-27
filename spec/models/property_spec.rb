require 'rails_helper'

describe Property, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:address) }

  
  it 'calculate average properties size' do
    properties = []
    4.times { |i| properties.push(create(:property, size: (i+10))) }
    expect(Property.average_size).to eq 11.50
  end

  it 'return markers detail' do
    properties = []
    4.times { |i| properties.push(create(:property)) }
    markers = Property.markers
    expect(markers.first).to include :lat, :lng, :name, :address
  end

end
