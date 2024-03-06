class Like < ApplicationRecord
  belongs_to :user
  belongs_to :plant

  validates :user_id, uniqueness: { scope: :plant_id }
end
