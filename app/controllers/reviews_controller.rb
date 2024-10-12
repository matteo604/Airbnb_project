class ReviewsController < ApplicationController
  def create
    @property = Property.find(params[:property_id])
    @booking = @property.bookings.find(params[:booking_id])
    if @booking.end_date < Date.today
      @review = @booking.reviews.new(review_params)
      @review.property = @property
      @review.user = current_user
      if @review.save
        redirect_to @property, notice: 'Review was successfully created.'
      else
         render 'properties/show'
      end
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to @review.property, notice: 'Review was successfully deleted.'
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
