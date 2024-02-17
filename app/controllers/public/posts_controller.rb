class Public::PostsController < ApplicationController

  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.save
    redirect_to public_posts_path
  end

  def index
    @post = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end
  
  private

  def post_params
    params.require(:post).permit(:user_id, :image, :sentence)
  end
end
