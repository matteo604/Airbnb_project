class PropertiesController < ApplicationController
  def index
    @properties = Property.all
  end

  def new
    @property = Property.new
  end

  def search
    if params[:query].present?
      @properties = Property.where("title ILIKE ? OR location ILIKE ?", "%#{params[:query]}%", "%#{params[:query]}%")
    else
      @properties = Property.all
    end
    render :index
  end

  def show
    @property = Property.find(params[:id])
  end

  def create
    @property = Property.new(property_params)
    @property.user = current_user

    if @property.save
      redirect_to @property, notice: 'Property was successfully created.'
    else
      render :new
    end
  end

  private

  def property_params
    params.require(:property).permit(:price_per_night, :title, :description, :location, :max_guests, :property_type)
  end
end
