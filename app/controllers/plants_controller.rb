class PlantsController < ApplicationController
  def index
    @plants = Plant.all
  end

  def show
  end

  def new
    @plant =Plant.new
  end

  def create
    @plant = current_user.plants.build(plant_params)

    if @plant.save
        redirect_to plants_path
    else
        render :new
    end

  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def plant_params
    params.require(:plant).permit(:name, :content, :image, :user_id, :family)
  end
end