class Public::PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    respond_to do |format|
      if @post.save
        format.html { redirect_to public_users_path(@post), notice: '新規投稿を行いました。' }
      else
        format.html { render :new }
      end
    end
    
  end

  def destroy
    @post = Post.find(params[:id])
    @post.user_id = current_user.id
    @post.destroy
    redirect_to public_user_path(current_user)
  end

  def index
    @post = Post.all
  end

  def show
    @post = Post.find(params[:id])

    if @post.status_non_public? && @post.user != current_user
      respond_to do |format|
        format.html { redirect_to public_user_path(current_user), notice: 'このページにはアクセスできません' }
      end
    else
      @user = @post.user
      @post_comment = PostComment.new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to public_user_post_path(current_user, @post)
    else
      render :edit
    end
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
    params.require(:post).permit(:user_id, :image, :sentence, :post_name, :status)
  end

  def user_params
    params.require(:user).permit(:name, :self_introduction, :image, :email, :profile_image)
  end
end
