class PropertiesController < ApplicationController

  def index
    json_response(Property.all)
  end

  def create
    @property = Property.new(property_params)
    if @property.save
      json_response(@property, :created)
    else
      json_response({message: @property.errors.full_messages}, :unprocessable_entity)
    end
  end

  def stats
    stats = { no_of_properties: Property.count, average_size: Property.average_size, markers: Property.markers}
    json_response(stats)
  end

  private

  def property_params
    params.require(:property).permit(:name, :address, :no_of_bathrooms, :no_of_bedrooms, :size)
  end

end
