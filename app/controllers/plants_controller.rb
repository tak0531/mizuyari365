class PlantsController < ApplicationController
  def index
    @plants = Plant.all.order(created_at: :desc)
  end

  def show
    @plant = Plant.find(params[:id])
  end

  def new
    @plant =Plant.new
  end

  def create
    @plant = current_user.plants.build(plant_params)

    if @plant.save
        @plant.plants_actions.create(last_watered: params[:plant][:last_watered], user_id: current_user.id)
        redirect_to plants_path
      else
        render :new
      end

  end

  def edit
    @plant = Plant.find(params[:id])
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
    else
        render :index, status: :see_other
    end
  end

  private

  def plant_params
    params.require(:plant).permit(:name, :content, :image, :user_id, :family)
  end
end