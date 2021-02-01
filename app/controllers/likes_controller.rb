class LikesController < ApplicationController
  def create
    idea = Idea.find params[:idea_id]
    like = Like.new idea: idea, user: current_user
    if !can?(:like, idea)
      flash[:alert] = "Can't like your own idea"
    elsif like.save
      flash[:notice] = "Liked +1"
    else
      flash[:alert] = like.errors.full_messages.join(", ")
    end
    redirect_to idea_path(idea)
  end

  def destroy
    like = current_user.likes.find params[:idea_id]
    @idea = like.idea
    if !can?(:destroy, like)
      flash[:alert] = "Can't unlike someone else's like"
    elsif like.destroy
      flash[:notice] = "Like -1"
    else
      flash[:alert] = "Couldn't unlike"
    end
    redirect_to idea_path(@idea)
  end
end
