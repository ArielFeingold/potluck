class Ingredient < ApplicationRecord
    validates :name, presence: true

  belongs_to :user
  has_many :ringredients
  has_many :recipes, :through => :ringredients
end
