class CreateRecipeIngredients < ActiveRecord::Migration
  def change
    create_table :recipe_ingredients do |t|
      t.integer :recipe_id
      t.integer :sort_key
      t.string :name
      t.string :quantity

      t.timestamps null: false
    end
    add_index :recipe_ingredients, :recipe_id
    add_foreign_key :recipe_ingredients, :recipe_id
  end
end
