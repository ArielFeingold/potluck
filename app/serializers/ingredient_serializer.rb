class IngredientSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :name, :unit
end
