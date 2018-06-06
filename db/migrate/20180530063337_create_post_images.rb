class CreatePostImages < ActiveRecord::Migration
  def change
    create_table :post_images do |t|
      t.string :mime_type
      t.binary :image

      t.references :imageable, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
