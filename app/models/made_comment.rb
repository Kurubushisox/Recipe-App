class MadeComment < ActiveRecord::Base
  belongs_to :user
  belongs_to :recipe
  before_save :verify_user

  private
    def  verify_user
      self.user_id != self.recipe.user_id
    end
end
