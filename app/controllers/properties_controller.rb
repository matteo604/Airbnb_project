class PropertiesController < ApplicationController
  def index
    @properties = Property.all
  end

  def new
    @property = Property.new
  end

  def search
    @properties = Property.all # initialize properties with all records

    if params[:query].present?
      # search properties by title or location
      @properties = @properties.where("title ILIKE ? OR location ILIKE ?", "%#{params[:query]}%", "%#{params[:query]}%")
    end

    if params[:who].present?
      # filter properties by the number of guests (max_guests >= selected number)
      @properties = @properties.where("max_guests >= ?", params[:who].to_i)
    end

    if @properties.empty?
      flash[:alert] = "No properties found matching your criteria."
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
