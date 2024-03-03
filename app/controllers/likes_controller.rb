class LikesController < ApplicationController
  def create
    plant = Plant.find_by(id: params[:plant_id])
    current_user.like(plant)
    redirect_to plant_path(plant)
  end
  
  def destroy
    plant = Plant.find_by(id: params[:plant_id])
    liked = Like.find_by(plant_id: params[:plant_id])
    if liked.user_id == current_user.id
      liked.destroy
    # plant = current_user.likes.find(params[:plant_id]).plant
    # current_user.unlike(plant)
    redirect_to plant_path(plant), status: :see_other
    end
  end
end