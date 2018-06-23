class MadeComment < ActiveRecord::Base
  REGISTRABLE_ATTRIBUTES = %i(content)
  belongs_to :user
  belongs_to :recipe
  has_one :post_image, as: :imageable, dependent: :destroy
  has_one :made_comment_reply, dependent: :destroy
  accepts_nested_attributes_for :post_image, allow_destroy: true

  after_initialize {
    build_post_image unless self.persisted? || post_image.present?
  }

  before_save :verify_user? do
    post_image.mark_for_destruction if post_image.image.blank?
  end

  private
    def  verify_user?
      self.user_id != self.recipe.user_id
    end
end
