class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :plant

  validates :content, length: { maximum: 100 }
end
