class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
    @post.post_type = params[:post_type] if params[:post_type].present?
  end

  def create
    post = Post.new post_params
    if post.save
      redirect_to posts_path, flash: { notice: "Your post was saved successfully" }
    else
      # redirect_to new_post_path, flash: { error: post.errors.full_messages }
      # flashes error to current page
      flash.now[:error] = post.errors.full_messages
      @post = post
      render :new
    end
  end

  def show
    @post = Post.find params[:id]
  end

  def edit
    @post = Post.find params[:id]
  end

  def update
    @post = Post.find params[:id]
    if @post.update post_params
      redirect_to posts_path, flash: { notice: "Your post was saved successfully" }
    else
      flash.now[:error] = @post.errors.full_messages
      @post = post
      render :edit
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :link, :body, :post_type)
  end
end
