class ChangeFamilyToIntegerInPlants < ActiveRecord::Migration[7.0]
  def change
    change_column :plants, :family, :integer, using: 'family::integer'
  end
end
