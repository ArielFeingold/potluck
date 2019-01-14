class Recipe < ApplicationRecord
  validates :title, :category, presence: true

  belongs_to :user
  has_many :ringredients 
  has_many :ingredients, :through => :ringredients
end
