class PropertiesController < ApplicationController
  def index
    @properties = Property.all
  end

  def new
    @property = Property.new
  end

  def create
    @property = Property.new(property_params)
    if @property.save
      redirect_to @property, notice: 'Property was successfully created.'
    else
      render :new
    end
  end

  private

  def property_params
    params.require(:property).permit(:price_per_night, :title, :description, :location, :max_guests, :property_type, :user_id)
  end
end
