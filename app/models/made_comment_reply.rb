class MadeCommentReply < ActiveRecord::Base
  REGISTRABLE_ATTRIBUTES = %i(content)
  belongs_to :user
  belongs_to :made_comment
end
