class UserSessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = login(params[:email], params[:password])

    if @user
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    logout
    redirect_to login_path, status: :see_other
  end
end