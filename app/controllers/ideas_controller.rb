class IdeasController < ApplicationController
  before_action :find_idea, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @ideas = Idea.order(created_at: :desc)
  end

  def new
    @idea = Idea.new
  end

  def show
    @reviews = @idea.reviews.order(created_at: :desc)
    @idea = Idea.find params[:id]
    @review = Review.new
    @like = @idea.likes.find_by(user: current_user)
  end

  def create
    @idea = Idea.new idea_params
    @idea.user = current_user
    if @idea.save
      flash[:notice] = "Idea posted successfully"
      redirect_to idea_path(@idea.id)
    else
      render :new
    end
  end

  def update
    if @idea.update idea_params
      redirect_to idea_path(@idea.id), notice: "Idea updated successfully"
    else
      render :edit
    end
  end

  def edit
  end

  def destroy
    @idea.destroy
    redirect_to ideas_path, alert: "Idea deleted"
  end

  private

  def find_idea
    @idea = Idea.find params[:id]
  end

  def idea_params
    params.require(:idea).permit(:title, :description)
  end
end
