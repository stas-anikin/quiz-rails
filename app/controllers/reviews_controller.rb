class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def new
    @review = Review.new
  end

  def create
    @idea = Idea.find params[:idea_id]
    @review = Review.new review_params
    @review.idea = @idea
    @review.user = current_user
    if @review.save
      redirect_to idea_path(@idea), notice: "review posted"
    else
      @review = @idea.reviews.order(created_at: :desc)
      render "/ideas/show"
    end
  end

  def destroy
    @review = Review.find params[:format]
    @review.destroy
    redirect_to idea_path(@review.idea), notice: "review deleted"
  end

  private

  def review_params
    params.require(:review).permit(:body)
  end
end
