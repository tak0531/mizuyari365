class ChangeFamilyNullConstraintInPlants < ActiveRecord::Migration[7.0]
  def change
    change_column_null :plants, :family, false
  end
end
