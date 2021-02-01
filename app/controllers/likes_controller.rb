class LikesController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :find_idea, only: [:create]

  def create
    like = Like.new(user: current_user, idea: @idea)

    if like.save
      flash[:success] = "Idea Liked"
    else
      flash[:danger] = like.errors.full_messages.join(", ")
    end

    redirect_to ideas_path
  end

  def destroy
    like = current_user.likes.find params[:id]

    if can? :destroy, like
      like.destroy
      flash[:success] = "Idea Unliked"
    else
      flash[:alert] = "Can't Unlike!"
    end
    redirect_to ideas_path
  end

  private

  def find_idea
    @idea = Idea.find params[:idea_id]
  end
end
