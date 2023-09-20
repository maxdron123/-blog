class PostsController < ApplicationController
  before_action :set_posts, only: %i[show edit update destroy]
  skip_before_action :authenticate_user!, only: :index

  def index
    @posts = Post.all
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @user = current_user
    @post = Post.new(post_params)
    @post.user = @user
    if @post.save
      redirect_to post_path(@post)
    else
      render :new, notice: "something gone wrong", status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "Post updated"
    else
      render :edit, status: :unproccessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, status: :see_other, notice: "Post deleted"
  end

  private

  def post_params
    params.require(:post).permit(:header, :body, :rating)
  end

  def set_posts
    @post = Post.find(params[:id])
  end
end
