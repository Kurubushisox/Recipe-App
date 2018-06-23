class MadeCommentReply < ActiveRecord::Base
  REGISTRABLE_ATTRIBUTES = %i(content)
  belongs_to :user
  belongs_to :made_comment

  before_save :verify_user?

  private
    def  verify_user?
      self.user_id = self.made_comment.recipe.user_id
      return true
    end
end
