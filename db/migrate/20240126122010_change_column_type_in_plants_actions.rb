class ChangeColumnTypeInPlantsActions < ActiveRecord::Migration[7.0]
  def change
    change_column :plants_actions, :last_watered, :date
    change_column :plants_actions, :new_pot, :date
  end
end
