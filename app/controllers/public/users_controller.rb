class Public::UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @posts = Post.order('id DESC').limit(5)
  end
  
  def index_follow
    @user = current_user
    @posts = Post.order("created_at DESC").where(user_id: [*current_user.following_ids]).limit(5)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
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
  
  def search
    if params[:keyword].present?
      @users = User.where('name LIKE ?', "%#{params[:keyword]}%")
      @keyword = params[:keyword]
    else
      @users = User.all
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
