class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :plants, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :products, dependent: :destroy
  has_many :like_plants, through: :likes, source: :plant

  has_one_attached :avatar

  validates :password, length: { minimum: 7 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true, presence: true
  validates :name, presence: true, length: { maximum: 255 }

  validate :validate_product_limit, on: :create

  def own?(object)
    id == object&.user_id
  end

  def like(plant)
    like_plants << plant
  end

  def unlike(plant)
    like_plants.destroy(plant)
  end

  def like?(plant)
    like_plants.include?(plant)
  end

  def image_content_type
    errors.add(:image, '：ファイル形式が、JPEG, PNG, GIF以外になってます。ファイル形式をご確認ください。') if image.attached? && !image.content_type.in?(%w[image/jpeg image/png image/gif])
  end

  def image_size
    errors.add(:image, '：1MB以下のファイルをアップロードしてください。') if image.attached? && image.blob.byte_size > 1.megabytes
  end

  def formatted_created_at
    created_at.strftime('%Y年%m月%d日')
  end

  def validate_product_limit
    errors.add(:base, '商品を3つまでしか登録できません') if products.count >= 3
  end
end
