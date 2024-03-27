class Product < ApplicationRecord
  belongs_to :user

  def self.ransackable_attributes(_auth_object = nil)
    ["created_at", "id", "name", "price", "product_image", "rakuten_url", "updated_at", "user_id"]
  end
end
