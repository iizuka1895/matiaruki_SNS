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
  
  def check
    @user = current_user
  end
  
  def withdrawl
    current_user.update(is_active: false)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end
  
  def liked_posts
    @liked_posts = Post.liked_posts(current_user, params[:page], 10)
  end

  private
  def user_params
    params.require(:user).permit(:name, :self_introduction, :image, :email, :profile_image)
  end
end
