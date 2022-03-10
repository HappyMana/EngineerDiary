class UsersController < ApplicationController
  def show
    if user_signed_in?
      @user = User.find(current_user.id)
      @posts = Post.where(user_id: current_user.id)
    else
      redirect_to new_user_session_path
    end
  end
end
