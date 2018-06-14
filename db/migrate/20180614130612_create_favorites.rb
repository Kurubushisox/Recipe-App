class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.integer :user_id, null: false
      t.integer :recipe_id, null: false

      t.timestamps null: false
    end
    add_index :favorites, :user_id
    add_index :favorites, :recipe_id
    add_foreign_key :favorites, :users
    add_foreign_key :favorites, :recipes
  end
end
