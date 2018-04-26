class Property < ApplicationRecord

  validates :name, :address, presence: true

  geocoded_by :address
  after_validation :geocode
  reverse_geocoded_by :latitude, :longitude

  def self.average_size
    (self.pluck(:size).sum / self.count).round(2)
  end

  def self.markers
    markers_data = self.pluck(:latitude, :longitude, :name, :address)
    markers_data.map {|m| {lat: m[0], lng: m[1], name: m[2], address: m[3] } if m[0] && m[1] }.compact
  end

end
