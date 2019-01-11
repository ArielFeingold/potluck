class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.text :about
      t.date :birthday
      t.string :gender
      t.string :country
      t.string :city
      t.string :imgURL

      t.timestamps
    end
  end
end
