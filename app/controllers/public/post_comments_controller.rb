class Public::PostCommentsController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.post_id = post.id
    comment.save
    redirect_to public_user_post_path(user_id: params[:user_id], id: params[:post_id])
  end

  def destroy
    PostComment.find(params[:id]).destroy
    redirect_to public_user_post_path(user_id: params[:user_id], id: params[:post_id])
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end
