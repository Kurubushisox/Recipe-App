class RecipeStep < ActiveRecord::Base
  belongs_to :recipe
  has_one :post_image, as: :imageable, dependent: :destroy

  accepts_nested_attributes_for :post_image, allow_destroy: true
end
