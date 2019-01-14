class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :title, :ingredients, :category
  belongs_to :user
  has_many :ringredients
end
