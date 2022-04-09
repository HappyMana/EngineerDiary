class LikesController < ApplicationController

  def create
    @like = Like.new({post_id: params[:post_id], user_id: current_user.id})
    if @like.save
      redirect_to request.referer
    else
      render root_path
    end
  end

  def destroy
    @like = Like.find_by(post_id: params[:post_id], user_id: current_user.id).destroy
    redirect_to request.referer
  end
end
