class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.integer :user_id
      t.string :name
      t.integer :required_time
      t.text :summary
      t.integer :serving_for
      t.boolean :private, default: true

      t.timestamps null: false
    end

    #add_index :recipes, :user_id
    #add_foreign_key :recipes :users
    #add_foreign_key :recipes :post_images
  end
end
