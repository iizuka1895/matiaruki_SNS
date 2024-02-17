class Public::UsersController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def show
    @posts = current_user.posts
    @user = current_user
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to public_user_path(current_user)
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :self_introduction, :image, :email, :profile_image)
  end
end
