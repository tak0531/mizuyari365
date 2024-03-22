class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.integer :price
      t.string :rakuten_url
      t.string :product_image

      t.timestamps
    end
  end
end
