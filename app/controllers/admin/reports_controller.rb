class Admin::ReportsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @reports = Report.order("created_at DESC")
    @users = User.all
  end
  
end