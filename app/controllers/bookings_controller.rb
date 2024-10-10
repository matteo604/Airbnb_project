class BookingsController < ApplicationController
  def new
    @property = Property.find(params[:property_id])
    @booking = @property.bookings.new
  end

  def create
    @property = Property.find(params[:property_id])
    @booking = @property.bookings.new(booking_params)
    @booking.user = current_user

    if @booking.save
      redirect_to @booking, notice: 'Booking was successfully created.'
    else
      render :new
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :number_of_guests, :total_price)
  end
end
