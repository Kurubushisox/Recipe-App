class CreateRecipeSteps < ActiveRecord::Migration
  def change
    create_table :recipe_steps do |t|
      t.integer :recipe_id
      t.integer :order
      t.text :content

      t.timestamps null: false
    end

    #add_index :recipe_steps, [:recipe_id, :order], unique: true
    add_foreign_key :reipe_steps, :reipes
    #add_foreign_key :recipes :post_images
  end
end
