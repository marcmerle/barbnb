# frozen_string_literal: true

#
## Review Controller
# Creation nested in Booking#show
# Show nested in Bar#show
class ReviewsController < ApplicationController
  def create
    @booking = Booking.find(params[:bar_id])
    @review = Review.new(review_params)
    @review.booking = @booking
    return redirect_to(@booking) if @review.save

    render "bookings/show"
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
