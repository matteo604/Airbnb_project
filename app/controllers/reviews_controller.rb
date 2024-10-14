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
    else
      redirect_to @property, alert: 'You cannot leave a review before the booking has ended.'
    end
  end

  def destroy
    @review = Review.find(params[:id])

    if @review.user == current_user
      @review.destroy
      redirect_to @review.property, notice: 'Review was successfully deleted.'
    else
      redirect_to @review.property, alert: 'You are not authorized to delete this review.'
    end
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
