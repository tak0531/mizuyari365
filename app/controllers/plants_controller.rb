class PlantsController < ApplicationController
  before_action :correct_user, only: [:edit, :update]

  def index
    @plants = current_user.plants.order(created_at: :desc)
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
    @new_pot = @plant.plants_actions.last&.new_pot
  end

  def new
    @plant = Plant.new
  end

  def edit
    @plant = Plant.find(params[:id])
    @plant_actions = @plant.plants_actions
  end

  def create
    @plant = current_user.plants.build(plant_params)
    @plants_action = @plant.plants_actions.build(last_watered: params[:plant][:last_watered], new_pot: params[:plant][:new_pot], user_id: current_user.id)

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
    @plant_actions = @plant.plants_actions

    if @plant.update(plant_params) && @plant_actions.update(new_pot: params[:plant][:new_pot])
      redirect_to plant_path(@plant)
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

    if @plants_action.update(last_watered: Time.zone.today)
      flash[:success] = "水やりが完了しました"
    else
      flash[:error] = "水やりの更新に失敗しました"
    end

    redirect_to plants_path
  end

  def suggest
    query = params[:q].tr('ァ-ン', 'ぁ-ん')
    query_katakana = params[:q].tr('ぁ-ん', 'ァ-ン')
    @plants_hiragana = Plant.where("name LIKE ? AND user_id != ?", "#{query}%", current_user.id).select(:name).distinct
    @plants_katakana = Plant.where("name LIKE ? AND user_id != ?", "#{query_katakana}%", current_user.id).select(:name).distinct
    @plants = (@plants_hiragana + @plants_katakana).uniq
    respond_to do |format|
      format.js
    end
  end

  private

  def plant_params
    params.require(:plant).permit(:name, :content, :image, :user_id, :family)
  end

  def plants_actions_params
    params.require(:plants_actions).permit(:new_pot)
  end

  def correct_user
    @plant = Plant.find(params[:id])
    @user = @plant.user
    redirect_to(plants_path) unless @user == current_user
  end
end
