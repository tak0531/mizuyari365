class Product < ApplicationRecord
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "name", "price", "product_image", "rakuten_url", "updated_at", "user_id"]
  end
end
