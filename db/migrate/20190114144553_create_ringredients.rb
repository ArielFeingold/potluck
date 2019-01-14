class CreateRingredients < ActiveRecord::Migration[5.2]
  def change
    create_table :ringredients do |t|
      t.integer :ingredient_id
      t.integer :recipe_id
      t.float :quantity

      t.timestamps
    end
  end
end
