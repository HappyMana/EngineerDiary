class PostsController < ApplicationController
  def index
    @posts = Post.where(is_public: true).or(Post.where(user_id: current_user.id)).order("created_at DESC").page(params[:page]).per(9)
  end

  def show
    @post = Post.find(params[:id])
    @user = User.find(current_user.id)
    @posts = Post.where(tag_id: @post.tag_id).page(params[:page]).per(5)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to action: "index"
    else
      flash[:alert] = "エラー：#{@post.errors.full_messages}"
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
    # タグ検索
    if params[:tag_id] == ""
      @posts = Post.where(is_public: true).or(Post.where(user_id: current_user.id)).limit(100).order("created_at DESC").page(params[:page]).per(9)
    else
      @posts = Post.where(tag_id: params[:tag_id], is_public: true).or(Post.where(user_id: current_user.id)).limit(100).order("created_at DESC").page(params[:page]).per(9)
    end
    # 並べ順検索
    # case params[:sort_id]
    # when "desc" then
    #   @posts.order("created_at DESC")
    # when "like" then
    #   @posts = Like.joins(@posts).group(:post_id).order(@posts.likes.count)
    # else
    # end
    render "index"
  end

  private
    def post_params
      get_params = params.require(:post).permit(:title, :text, :url, :tag_id, :is_public, :is_read).merge(user_id: current_user.id)
      site_title, site_img = scrape_params_info(get_params[:url])
      get_params.merge(site_title: site_title, site_img: site_img)
    end

    def scrape_params_info(url)
      require 'open-uri'
      require 'nokogiri'

      target_url = url
      p "------#{target_url}"
      charset = nil
      html = open(target_url) do |f|
        charset = f.charset
        f.read
      end

      contents = Nokogiri::HTML(html, nil, charset)
      p "------#{contents}"
      # site title
      if contents.css('//meta[property="og:title"]/@content').empty?
        site_title = contents.title.to_s
      else
        site_title = contents.css('//meta[property="og:title"]/@content').to_s
      end
      p "------#{site_title}"

      # site image
      if contents.css('//meta[property="og:image"]/@content').nil?
        site_img = 'default_ogp_image.png'
        p "---画像ない"
      else
        site_img =  contents.css('//meta[property="og:image"]/@content').to_s
      end
      p "------#{site_img}"

      return site_title, site_img
    end
end
