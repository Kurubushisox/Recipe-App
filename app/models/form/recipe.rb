class Form::Recipe < Recipe
  REGISTRABLE_ATTRIBUTES = %i(name required_time summary serving_for private)
  has_many :recipe_ingredients , class_name: 'Form::RecipeIngredient', dependent: :destroy
  has_many :recipe_steps, class_name: 'Form::RecipeStep', dependent: :destroy
  has_one :post_image, class_name: 'Form::PostImage', as: :imageable, dependent: :destroy

  after_initialize {
    3.times {recipe_ingredients.build} unless self.persisted? || recipe_ingredients.present?
    2.times {recipe_steps.build} unless self.persisted? || recipe_steps.present?
    build_post_image unless self.persisted? || post_image.present?
  }

  before_save do
    self.name.gsub!(/\r\n|\r|\n|\s|\t/, "")
    self.summary.gsub!(/\r\n|\r|\n|\s|\t/, "")
  end
end
