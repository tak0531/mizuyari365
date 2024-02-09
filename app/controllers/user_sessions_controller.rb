class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  def new
    @user = User.new
  end

  def create
    @user = login(params[:email], params[:password])

    if @user
      redirect_to root_path
      flash[:success] = "ログインしました"
    else
      @model = Model.new
      flash.now[:danger] = "ログインできませんでした"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to login_path, status: :see_other
    flash[:success] = "ログアウトしました"
  end
end