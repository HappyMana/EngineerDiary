class LikesController < ApplicationController

  def create
    @like = Like.new(like_params)
    if @like.save
      redirect_to request.referer
    else
      flash.now[:alert] = 'いいねに失敗しました'
      render request.referer
    end
  end

  def destroy
    @like = Like.find_by(post_id: params[:post_id], user_id: current_user.id).destroy
    redirect_to request.referer
  end

  private
  def like_params
    params.permit(:post_id).merge(user_id: current_user.id)
  end
end
