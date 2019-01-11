class CreateRecipeIngredients < ActiveRecord::Migration[5.2]
  def change
    create_table :recipe_ingredients do |t|
      t.integer :user_id
      t.integer :recipe_id
      t.float :quantity

      t.timestamps
    end
  end
end
