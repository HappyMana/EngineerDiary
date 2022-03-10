class PostsController < ApplicationController
  def index
    @posts = Post.where(is_public: true)or(Post.where(user_id: current_user.id)).order("created_at DESC")
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to action: "index"
    else
      logger.debug "だめ"
      render "new"
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to @post
    else
      flash[:alert] = "エラー：#{@post.errors.full_messages}"
      render "edit"
    end
  end

  def destroy
    @tags = Tag.all
    Post.find(params[:id]).destroy
    redirect_to posts_path
  end

  def search
    if params[:tag_id] == ""
      @posts = Post.order("created_at DESC")
    else
      @posts = Post.where(tag_id: params[:tag_id]).limit(100)
    end
    render "index"
  end

  private
    def post_params
      params.require(:post).permit(:title, :text, :url, :tag_id, :is_public, :is_read).merge(user_id: current_user.id)
    end
end
