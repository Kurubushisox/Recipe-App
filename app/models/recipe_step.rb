class RecipeStep < ActiveRecord::Base
  REGISTRABLE_ATTRIBUTES = %i(id order content _destroy)
  belongs_to :recipe
  has_one :post_image, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :post_image, allow_destroy: true

  after_initialize {
    build_post_image unless self.persisted? || post_image.present?
  }
end
