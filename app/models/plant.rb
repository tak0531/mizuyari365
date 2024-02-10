class Plant < ApplicationRecord
  has_many :likes
  has_many :plants_actions, dependent: :destroy
  belongs_to :user


  has_one_attached:image

  enum family: { サボテン科: 0, その他: 1 }

  validates :family, presence: true
  validates :name, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["name"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["image_attachment", "image_blob", "likes", "plants_actions", "user"]
  end

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

  def watering_cycle(plant)
    last_w_day = plant.plants_actions.last&.last_watered
    result = []

    if plant.family == "その他"
      d7_watering = last_w_day + 7
      result << d7_watering
    else
      d11_watering = last_w_day + 11
      result << d11_watering
    end

    return result
    
  end
end