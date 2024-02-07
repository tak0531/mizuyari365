class Plant < ApplicationRecord
  has_many :likes
  has_many :plants_actions, dependent: :destroy
  belongs_to :user


  has_one_attached:image

  enum family: { サボテン科: 0, その他: 1 }

  validates :family, presence: true
  validates :name, presence: true

  def image_content_type
    if image.attached? && !image.content_type.in?(%w[image/jpeg image/png image/gif])
      errors.add(:image, '：ファイル形式が、JPEG, PNG, GIF以外になってます。ファイル形式をご確認ください。')
    end
  end

  def image_size
    if image.attached? && image.blob.byte_size > 1.megabytes
      errors.add(:image, '：1MB以下のファイルをアップロードしてください。')
    end
  end

  def formatted_created_at
    created_at.strftime('%Y年%m月%d日')
  end
end