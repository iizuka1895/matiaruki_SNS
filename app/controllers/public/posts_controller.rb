class Public::PostsController < ApplicationController

  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.save
    redirect_to public_user_path(current_user)
  end

  def index
    @post = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @user = User.find(@post.user_id)
    @post_comment = PostComment.new
  end
  
  def search
    if params[:keyword].present?
      @posts = Post.where('sentence LIKE ?', "%#{params[:keyword]}%")
      @keyword = params[:keyword]
    else
      @posts = Post.all
    end
  end
  
  private

  def post_params
    params.require(:post).permit(:user_id, :image, :sentence, :post_name)
  end
end
