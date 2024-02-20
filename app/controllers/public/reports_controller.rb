class Public::ReportsController < ApplicationController
  before_action :authenticate_user!
   
  def new
   @report = Report.new
   @post = Post.find(params[:post_id])
  end
  
  def create
    post = Post.find(params[:post_id])
    report = current_user.reports.new(report_params)
    report.post_id = post.id
    if report.save
      post.update(status: 0)
      flash[:notice] = "管理者に報告しました"
      redirect_to complete_public_post_path(post)
    else
      @report = Report.new
      @post = Post.find(params[:item_id])
      flash[:alert] = "正しい内容を入力してください"
      render "new"
    end
  end
  
  
  private

  def report_params
    params.require(:report).permit(:reports)
  end
end
