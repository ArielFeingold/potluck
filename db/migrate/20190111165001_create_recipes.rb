class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.integer :user_id
      t.string :title
      t.text :instructions
      t.string :category
      t.string :cuisine
      t.string :cook_time
      t.string :difficulty
      t.integer :feeds

      t.timestamps
    end
  end
end
