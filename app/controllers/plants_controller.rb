class PlantsController < ApplicationController
  before_action :correct_user, only: [:edit, :update]

  def index
    @plants = current_user.plants.all.order(created_at: :desc)
  end

  def show
    @plant = Plant.find(params[:id])
    @user = @plant.user
    @comment = Comment.new
    @comments = @plant.comments.includes(:user).order(created_at: :desc)
    last_w_day = @plant.plants_actions.last&.last_watered

    @water_day = if @plant.family == 'その他'
                   d7_watering = last_w_day + 7.days
                 else
                   d11_watering = last_w_day + 11.days
                 end
  end

  def new
    @plant = Plant.new
  end

  def edit
    @plant = Plant.find(params[:id])
  end

  def create
    @plant = current_user.plants.build(plant_params)
    @plants_action = @plant.plants_actions.build(last_watered: params[:plant][:last_watered], user_id: current_user.id)

    if @plant.save && @plants_action.save
      redirect_to plants_path
      flash[:success] = "植物を登録しました"
    else
      flash.now[:danger] = "植物の登録に失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @plant = Plant.find(params[:id])

    if @plant.update(plant_params)
      redirect_to plant_path
    else
      render :edit
    end
  end

  def destroy
    @plant = Plant.find(params[:id])

    if @plant.destroy
      redirect_to plants_path
      flash[:success] = "植物を削除しました"
    else

      flash[:danger] = "植物の削除に失敗しました"
      render :index, status: :unprocessable_entity

    end
  end

  def watered
    @plant = Plant.find(params[:id])
    @plants_action = @plant.plants_actions.last

    if @plants_action.update(last_watered: Date.today)
      flash[:success] = "水やりが完了しました"
    else
      flash[:error] = "水やりの更新に失敗しました"
    end

    redirect_to plants_path
  end

  private

  def plant_params
    params.require(:plant).permit(:name, :content, :image, :user_id, :family)
  end

  def correct_user
    @plant = Plant.find(params[:id])
    @user = @plant.user
    redirect_to(plants_path) unless @user == current_user
  end
end
