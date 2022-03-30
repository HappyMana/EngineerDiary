class UsersController < ApplicationController
  def likes
    @posts = Post.joins(:likes).where(user_id: current_user.id).page(params[:page]).per(9)
  end

  def show
    @user = User.find(params[:id])
    p params[:id]
    if @user.id == current_user.id
      @posts = Post.where(user_id: @user.id).order("created_at DESC").page(params[:page]).per(9)
      p "ユーザー自身のとき"
    else
      @posts = Post.where(user_id: @user.id, is_public: true).page(params[:page]).per(9)
      p "ユーザー自身じゃないとき"
    end
  end

  # def update
  #   @user = User.find(current_user)
  #   @user.update(update_params)
  #   redirect_to user_path(@user.id)
  # end

  def search
    # タグ検索
    if params[:tag_id] === ""
      @posts = Post.where(user_id: current_user.id).order("created_at DESC").page(params[:page]).per(9)
    else
      @posts = Post.where(tag_id: params[:tag_id], user_id: current_user.id).limit(100).order("created_at DESC").page(params[:page]).per(9)
    end
    # 読んだか読んでないか
    # if params[:is_read] === true
    #   @posts = Post.where(is_read: true, user_id: current_user.id).limit(100).order("created_at DESC").page(params[:page]).per(9)
    # else
    #   @posts = Post.where(is_read: false, user_id: current_user.id).limit(100).order("created_at DESC").page(params[:page]).per(9)
    # end
    # 並べ順検索
    # case params[:sort_id]
    # when "desc" then
    #   @posts.order("created_at DESC")
    # when "like" then
    # else
    # end
    render action: :show
  end

  private

  def update_params
    params.require(:user).permit(:name, :user_img)
  end
end
