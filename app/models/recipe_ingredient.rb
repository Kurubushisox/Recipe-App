class RecipeIngredient < ActiveRecord::Base
  REGISTRABLE_ATTRIBUTES = %i(id group name quantity _destroy)
  belongs_to :recipe
end
