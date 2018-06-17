class CreateMadeComments < ActiveRecord::Migration
  def change
    create_table :made_comments do |t|
      t.integer :user_id,   null: false
      t.integer :recipe_id, null: false
      t.string :content,    null: false, default: ''

      t.timestamps null: false
    end
    add_foreign_key :made_comments, :user_id
    add_foreign_key :made_comments, :recipe_id
  end
end
