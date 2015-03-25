class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    post = Post.new(params.require(:post).permit(:title, :link, :body))
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

end
