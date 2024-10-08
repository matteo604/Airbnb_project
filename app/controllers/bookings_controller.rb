class BookingsController < ApplicationController
  def new
    @property = Property.find(params[:property_id])
    @booking = @property.bookings.new
  end

  def create
    @property = Property.find(params[:property_id])
    @booking = @property.bookings.new(booking_params)
    @booking.user = current_user

    number_of_nights = (@booking.end_date - @booking.start_date).to_i
    @booking.total_price = number_of_nights * @property.price_per_night

    if @booking.save
      redirect_to @booking, notice: 'Booking was successfully created.'
    else
      render :new
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :number_of_guests)
  end
end
