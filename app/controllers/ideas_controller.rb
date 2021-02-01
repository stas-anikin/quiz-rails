class IdeasController < ApplicationController
  before_action :find_idea, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def index
    @ideas = Idea.all.order(created_at: :desc)
  end

  def new
    @idea = Idea.new
  end

  def show
    @reviews = @idea.reviews.order(created_at: :desc)
    @idea = Idea.find params[:id]
    @review = Review.new
  end

  private

  def find_idea
    @idea = Idea.find params[:id]
  end

  def idea_params
    params.require(:idea).permit(:title, :description)
  end
end
