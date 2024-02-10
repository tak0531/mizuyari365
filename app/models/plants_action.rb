class PlantsAction < ApplicationRecord
    belongs_to :plant


    validates :last_watered, presence: true


end