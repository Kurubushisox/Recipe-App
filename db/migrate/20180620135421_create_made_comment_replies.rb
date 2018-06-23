class CreateMadeCommentReplies < ActiveRecord::Migration
  def change
    create_table :made_comment_replies do |t|
      t.integer :user_id,         null: false
      t.integer :made_comment_id, null: false
      t.string :content,          null: false, default: ''

      t.timestamps null: false
    end
    add_foreign_key :made_comments_replies, :user_id
    add_foreign_key :made_comments_replies, :made_comment_id
  end
end
