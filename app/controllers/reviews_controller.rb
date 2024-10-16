class ReviewsController < ApplicationController
  def create

    # @property = Property.find(params[:property_id])
    @booking = Booking.find(params[:booking_id])

    @review = @booking.build_review(review_params)
    # @review.property = @property
    # @review.user = current_user

    if @review.save
      redirect_to booking_path(@booking), notice: 'Review was successfully created.'
    else
      render 'bookings/show', status: :unprocessable_entity
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
    params.require(:review).permit(:content, :rating).merge(user_id: current_user.id, property_id: @booking.property_id)
  end
end
