class Recipe < ActiveRecord::Base
  REGISTRABLE_ATTRIBUTES = %i(name required_time summary serving_for private)
  belongs_to :user
  has_many :recipe_steps, dependent: :destroy
  has_many :recipe_ingredients, dependent: :destroy
  has_one  :post_image, as: :imageable, dependent: :destroy
  has_many :likes
  has_many :liked_by, through: :likes, source: :user
  has_many :made_comments, dependent: :destroy

  accepts_nested_attributes_for :recipe_steps, allow_destroy: true, reject_if: :reject_recipe_step
  accepts_nested_attributes_for :recipe_ingredients, allow_destroy: true, reject_if: :reject_recipe_ingredient
  accepts_nested_attributes_for :post_image, allow_destroy: true, reject_if: proc {|attributes| attributes['image'].blank? }

  validates :name, :serving_for,
            presence: true

  validates :name,
            length: { maximum: 20 }

  validates :summary,
            length: { maximum: 140 }

  validates :serving_for,
            numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 100 }

  after_initialize do
    3.times {recipe_ingredients.build} unless self.persisted? || recipe_ingredients.present?
    2.times {recipe_steps.build} unless self.persisted? || recipe_steps.present?
    build_post_image unless self.persisted? || post_image.present?
  end

  before_save do
    self.name.gsub!(/\r\n|\r|\n|\s|\t/, "")
    self.summary.gsub!(/\r\n|\r|\n|\s|\t/, "")
    recipe_ingredients.each{ |ingredient| ingredient.mark_for_destruction if ingredient.name.blank? }
    recipe_steps.each{ |step| step.mark_for_destruction if step.content.blank? }
  end

  def reject_recipe_ingredient(attributes)
    exists = attributes[:id].present?
    empty  = attributes[:name].blank?
    attributes.merge!(_destroy: true) if exists && empty
    !exists && empty
  end

  def reject_recipe_step(attributes)
    exists = attributes[:id].present?
    empty  = attributes[:content].blank?
    attributes.merge!(_destroy: true) if exists && empty
    !exists && empty
  end



  # SQLでWHERE LIKEに渡すキーワードをエスケープする
  def self.escape_like(string)
    string.gsub(/[\\%_]/){|m| "\\#{m}"}
  end

  # レシピをスペース区切りのキーワードで検索し、結果の配列を返す
  def self.search_recipe_by_keywords(post_string)

    keywords = post_string.gsub(/　/, "\s").strip.split("\s")

    var_dump = []
    keywords.each do |keyword|
      var_dump << "(recipes.name LIKE '%" + escape_like(keyword) + "%' ESCAPE '\\') OR (recipe_ingredients.name LIKE '%" + escape_like(keyword) + "%' ESCAPE '\\')"
    end

    keyword_condition = var_dump.join(' AND ')

    return self.joins('LEFT OUTER JOIN recipe_ingredients ON recipes.id = recipe_ingredients.recipe_id').where(keyword_condition).distinct
  end
end
