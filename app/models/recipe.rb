class Recipe < ActiveRecord::Base
  belongs_to :user
  has_many :recipe_steps, dependent: :destroy
  has_many :recipe_ingredients, dependent: :destroy
  has_one :post_image, as: :imageable, dependent: :destroy

  accepts_nested_attributes_for :recipe_steps, allow_destroy: true, reject_if: :reject_recipe_step
  accepts_nested_attributes_for :recipe_ingredients, allow_destroy: true, reject_if: :reject_recipe_ingredient
  accepts_nested_attributes_for :post_image, allow_destroy: true, reject_if: proc {|attributes| attributes['image'].blank? }

  validates :name, :serving_for, :post_image,
            presence: true

  validates :name,
            length: { maximum: 20 }

  validates :summary,
            length: { maximum: 140 }

  validates :serving_for,
            numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 100 }

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

=begin
  # SQLでWHERE LIKEに渡すキーワードをエスケープする
  def self.escape_like(string)
    string.gsub(/[\\%_]/){|m| "\\#{m}"}
  end

  # レシピをスペース区切りのキーワードで検索し、結果の配列を返す
  def self.search_recipe_by_keywords(post_string)

    keywords = post_string.gsub(/　/, "\s").strip.split("\s")

    var_dump = []
    keywords.each do |keyword|
      var_dump << "(name LIKE '%" + escape_like(keyword) + "%' ESCAPE '\\') OR (ingredients LIKE '%" + escape_like(keyword) + "%' ESCAPE '\\')"
    end

    keyword_condition = var_dump.join(' AND ')

    return self.where(keyword_condition)
  end
=end

end
