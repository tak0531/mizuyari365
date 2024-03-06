class ApplicationController < ActionController::Base
  before_action :require_login
  before_action :search

  def search
    @q = Plant.ransack(params[:q])
    @plants = @q.result(distinct: true).includes(:user).order(created_at: :desc)
  end

  private

  def not_authenticated
    redirect_to login_path
  end
end
