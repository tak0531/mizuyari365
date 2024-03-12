class Plant < ApplicationRecord
  has_many :likes, dependent: :destroy
  has_many :plants_actions, dependent: :destroy
  has_many :comments, dependent: :destroy
  belongs_to :user

  has_one_attached :image

  enum family: { サボテン科: 0, その他: 1 }

  validates :family, presence: true
  validates :name, presence: true
  validate :image_content_type, :image_size

  def self.ransackable_attributes(_auth_object = nil)
    ["name"]
  end

  def self.ransackable_associations(_auth_object = nil)
    ["image_attachment", "image_blob", "likes", "plants_actions", "user"]
  end

  def image_content_type
    errors.add(:image, '：ファイル形式が、JPEG, PNG, 以外になってます。ファイル形式をご確認ください。') if image.attached? && !image.content_type.in?(%w[image/jpeg image/png])
  end

  def image_size
    errors.add(:image, '：5MB以下のファイルをアップロードしてください。') if image.attached? && image.blob.byte_size > 5.megabytes
  end

  def formatted_created_at
    created_at.strftime('%Y年%m月%d日')
  end

  def watering_cycle(plant)
    last_w_day = plant.plants_actions.last&.last_watered
    result = [plant.name]

    if plant.family == "その他"

      d7_watering = last_w_day + 7.days
      forget_3times_for7 = last_w_day + 21.days
      water_remaining7 = (d7_watering - Time.zone.today).to_i

      if water_remaining7 >= 4
        result << 0
      elsif water_remaining7.zero?
        result << '今日'
      elsif Time.zone.today >= forget_3times_for7
        result << "3回以上水やりを忘れています。"
      elsif water_remaining7.negative?
        abs_remaining_days7 = water_remaining7.abs
        result << "#{abs_remaining_days7}日前"
      else
        result << "#{water_remaining7}日後"
      end

    else

      d11_watering = last_w_day + 11.days
      forget_3times_for11 = last_w_day + 33.days
      water_remaining11 = (d11_watering - Time.zone.today).to_i
      if water_remaining11 >= 4
        result << 0
      elsif water_remaining11.zero?
        result << '今日'
      elsif Time.zone.today >= forget_3times_for11
        result << "3回以上水やりを忘れています。"
      elsif water_remaining11.negative?
        abs_remaining_days11 = water_remaining11.abs
        result << "#{abs_remaining_days11}日前"
      else
        result << "#{water_remaining11}日後"
      end

    end

    result
  end
end
