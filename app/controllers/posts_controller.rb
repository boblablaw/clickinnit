class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :authorized_user, only: [:edit, :update, :destroy]
  def index
    @posts = Post.includes(:comment_threads).page(params[:page])
  end

  def new
    @post = Post.new
    @post.post_type = params[:post_type] if params[:post_type].present?
  end

  def create
    post = Post.new post_params
    post.user_id = current_user.id
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

  def save
    @post = Post.find params[:id]
    ElevenNote.create_from @post

    redirect_to @post, notice: 'Saved to ElevenNote!'
  rescue
    redirect_to @post, alert: 'We were unable to save that to ElevenNote.'
  end

  def show
    @post = Post.find params[:id]
    @comment = Comment.build_from(@post, current_user.id, '')
  end

  def edit
  end

  def upvote
    @post = Post.find params[:id]
    @post.upvote_by current_user
    redirect_to :back
  end

  def downvote
    @post = Post.find params[:id]
    @post.downvote_by current_user
    redirect_to :back
  end

  def update
    if @post.update post_params
      redirect_to posts_path, flash: { notice: "Your post was saved successfully" }
    else
      flash.now[:error] = @post.errors.full_messages
      @post = post
      render :edit
    end
  end

  def destroy
    post = Post.find params[:id]
    if post.destroy
      redirect_to posts_path, flash: { notice: 'Your post has been removed.' }
    else
      redirect_to posts_path, flash: { notice: 'We were unable to remove that post.' }
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :link, :body, :post_type, :category_id, :user_id)
  end

  def find_post
    @post = Post.find params[:id]
  end

  def authorized_user
    @post = current_user.posts.find_by(id: params[:id])
    redirect_to posts_path, notice: 'Not authorized to edit this post' if @post.nil?
  end
end
