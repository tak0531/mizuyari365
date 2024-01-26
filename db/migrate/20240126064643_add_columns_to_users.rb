class AddColumnsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string
    add_column :users, :line_id, :string
    add_index :users, :line_id, unique: true
  end
end
