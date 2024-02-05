class RemoveAllPlants < ActiveRecord::Migration[7.0]
  def change
    Plant.destroy_all
  end
end
