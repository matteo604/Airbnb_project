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
      if @properties.empty?
       flash[:alert] = "Please type the correct location or title."
      end
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
      redirect_to properties_path, notice: 'Property was successfully created.'
    else
     render :new
    end
  end


  def edit
    @property = Property.find(params[:id])
    if @property.user != current_user
        redirect_to properties_path, alert: "You can't update the property if you are not the owner."
    end
  end

  def update
    @property = Property.find(params[:id])
    if @property.update(property_params)
      redirect_to @property, notice: 'Property was successfully updated.'
    else
      render :edit
    end
  end

  private

  def property_params
    params.require(:property).permit(:price_per_night, :title, :description, :location, :max_guests, :property_type, :photo)
  end
end
