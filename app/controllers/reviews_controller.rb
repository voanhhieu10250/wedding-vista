class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_service

  def create
    @review = Review.new(review_params)
    @review.user = current_user
    @review.service = @service

    if @review.save
      redirect_to service_path(@service), notice: 'Review was successfully created.'
    else
      flash_errors_message(@review, now: true)
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :title, :body)
  end

  def set_service
    @service = Service.find(params[:service_id])
  end
end
