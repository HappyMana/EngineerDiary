class PostsController < ApplicationController

  before_action :authenticate_user!, except: [:index]

  def index
    if user_signed_in?
      @posts = Post.includes(:user, tags: :posts).where(is_public: true).or(Post.where(user_id: current_user.id)).order("created_at DESC").page(params[:page]).per(9)
    else
      @posts = Post.includes(:user, tags: :posts).where(is_public: true).order("created_at DESC").page(params[:page]).per(9)
    end
  end

  def show
    @post = Post.find(params[:id])
    # @posts = Post.includes(taggings: :tags).where(tag_id: @post.tag).page(params[:page]).per(5)
  end

  def new
    @post = Post.new
    @post.tags.build
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to action: "index"
    else
      flash.now[:alert] = "投稿に失敗しました"
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
      flash.now[:alert] = "更新に失敗しました"
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
      # @posts = Like.includes(:posts).group(:post_id).order("count DESC").count
    render "index"
  end

  private

  def post_params
    get_params = params.require(:post).permit(:title, :text, :url, :is_public, :is_read, tags_attributes: [:name]).merge(user_id: current_user.id)
    site_title, site_img = scrape_params_info(get_params[:url])
    get_params.merge(site_title: site_title, site_img: site_img)
  end

  def scrape_params_info(url)
    require 'open-uri'
    require 'nokogiri'

    target_url = url
    charset = nil
    html = open(target_url) do |f|
      charset = f.charset
      f.read
    end

    contents = Nokogiri::HTML(html, nil, charset)

    # site title
    if contents.css('//meta[property="og:title"]/@content').empty?
      site_title = contents.title.to_s
    else
      site_title = contents.css('//meta[property="og:title"]/@content').to_s
    end

    # site image
    if contents.css('//meta[property="og:image"]/@content').nil?
      site_img = 'default_ogp_image.png'
    else
      site_img =  contents.css('//meta[property="og:image"]/@content').to_s
    end

    return site_title, site_img
  end
end
