class Plant < ApplicationRecord
  has_many :likes, dependent: :destroy
  has_many :plants_actions, dependent: :destroy
  has_many :comments, dependent: :destroy
  belongs_to :user

  has_one_attached :image

  enum family: { サボテン科: 0, その他: 1 }

  validates :family, presence: true
  validates :name, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    ["name"]
  end

  def self.ransackable_associations(_auth_object = nil)
    ["image_attachment", "image_blob", "likes", "plants_actions", "user"]
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

  def watering_cycle(plant)
    last_w_day = plant.plants_actions.last&.last_watered
    result = [plant.name]

    if plant.family == "その他"

      d7_watering = last_w_day + 7.days
      forget_3times = last_w_day + 21.days
      water_remaining7 = (d7_watering - Date.today).to_i
      forgot_watering = (forget_3times - Date.today).to_i

      if water_remaining7 >= 4
        result << 0
      elsif water_remaining7 == 0
        result << '今日'
      elsif Date.today >= forget_3times
        result << "3回以上水やりを忘れています。"
      elsif water_remaining7 < 0
        abs_remaining_days7 = water_remaining7.abs
        result << "#{abs_remaining_days7}日前"
      else
        result << "#{water_remaining7}日後"
      end

    else

      d11_watering = last_w_day + 11.days
      water_remaining11 = (d11_watering - Date.today).to_i
      if water_remaining11 >= 4
        result << 0
      elsif water_remaining11 == 0
        result << '今日'
      elsif water_remaining11 < 0
        abs_remaining_days11 = water_remaining11.abs
        result << "#{abs_remaining_days11}日前"
      else
        result << "#{water_remaining11}日後"
      end

    end

    result
  end
end
