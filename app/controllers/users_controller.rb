class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  def index
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to login_path
      flash[:success] = "アカウントを作成しました"
    else
      render :new, status: :unprocessable_entity
      flash.now[:danger] = "アカウントの作成に失敗しました"
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def search_index
    user = User.find_by(id: params[:user_id])
    keyword = params[:name_cont]
    p keyword
    if keyword.present?
      @plants = user.plants.where("name LIKE ?", "%#{keyword}%")
    else
      @plants = user.plants.all
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar, :line_id)
  end
  
end