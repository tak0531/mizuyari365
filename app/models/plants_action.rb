class PlantsAction < ApplicationRecord
    belongs_to :plant

    validates :last_watered, presence: { message: "Last watered can't be blank" }
end