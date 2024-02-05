class ChangeFamilyNullInPlants < ActiveRecord::Migration[7.0]
  def change
    change_column_null :plants, :family, true
  end
end
