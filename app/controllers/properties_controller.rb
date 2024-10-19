class PropertiesController < ApplicationController
  def index
    @properties = Property.all
    @markers = @properties.geocoded.map do |property|
      {
        lat: property.latitude,
        lng: property.longitude,
        info_window: render_to_string(partial: "popup", locals: {property: property}),
        marker_html: "<i class='fas fa-map-marker-alt' style='color: black; font-size: 30px;'></i>"
      }
    end
  end

  def new
    @property = Property.new
  end

  def search
    if params[:query].present?
      # search properties using pg_search
      @properties = Property.search_by_title_and_location(params[:query])
    else
      @properties = Property.all
    end

    if params[:who].present?
      # filter properties by the number of guests (max_guests >= selected number)
      @properties = @properties.where("max_guests >= ?", params[:who].to_i)
    end

    if @properties.empty?
      flash[:alert] = "No properties found matching your criteria."
    end

    @markers = @properties.geocoded.map do |property|
      {
        lat: property.latitude,
        lng: property.longitude,
        info_window: render_to_string(partial: "popup", locals: {property: property}),
        marker_html: "<i class='fas fa-map-marker-alt' style='color: black; font-size: 30px;'></i>"
      }
    end

    render :index
  end

  def show
      @property = Property.find(params[:id])
      @markers = [{lat: @property.latitude, lng: @property.longitude}]
      # This is a booking instance so we the booking form in the show page.
      @booking = Booking.new
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

  # updated action for ajax-suggestions with pg_search
  def suggestions
    if params[:query].present?
      suggestions = Property.search_by_title_and_location(params[:query])

      # return title and location without highlight for now
      results = suggestions.map do |property|
        {
          title: property.title,
          location: property.location
        }
      end

      render json: results
    else
      render json: []
    end
  end


  private

  def property_params
    params.require(:property).permit(:price_per_night, :title, :description, :location, :max_guests, :property_type, :photo)
  end
end
