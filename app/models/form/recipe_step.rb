class Form::RecipeStep < RecipeStep
  REGISTRABLE_ATTRIBUTES = %i(id order content _destroy)
  has_one :post_image, class_name: 'Form::PostImage', as: :imageable,  dependent: :destroy

    after_initialize {
      build_post_image unless self.persisted? || post_image.present?
    }
end
