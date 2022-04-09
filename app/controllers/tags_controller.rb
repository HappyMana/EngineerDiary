class TagsController < ApplicationController
  def new
    @tag = Tag.new
    flash[:alert] = "tag_new"
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to controller: :posts, action: :new
    else
      render "new"
    end
  end

  private
  def tag_params
    params.require(:tag).permit(:tag_name)
  end
end
