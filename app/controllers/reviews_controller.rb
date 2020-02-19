# frozen_string_literal: true

#
## Review Controller
# Creation and Showing nested in the Bar#show
class ReviewsController < ApplicationController
  def create
    @bar = Bar.find(params[:bar_id])
    @review = Review.new(review_params)
    @review.bar = @bar
    return redirect_to(@bar) if @review.save

    render "bars/show"
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
