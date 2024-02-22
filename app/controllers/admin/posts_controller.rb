class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @posts = Post.all
  end
  
  def show
    @user = User.find(params[:id])
    @posts = Post.find(params[:id])
  end
  
  
  private
  def user_params
    params.require(:user).permit(:name, :self_introduction, :image, :email, :profile_image)
  end
  def post_params
    params.require(:user).permit(:name, :self_introduction, :image, :email, :profile_image)
  end
end