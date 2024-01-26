class CreatePlantsActions < ActiveRecord::Migration[7.0]
  def change
    create_table :plants_actions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :plant, null: false, foreign_key: true
      t.datetime :last_watered
      t.datetime :new_pot

      t.timestamps
    end
  end
end
