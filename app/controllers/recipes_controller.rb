class RecipesController < ApplicationController
  before_action :authenticate_user!, except: %i(index show)
  before_action :set_recipe, only: %i(show edit update destroy)

  def index
    @recipes = Recipe.limit(20).order('created_at DESC')
    flash.now[:warning] = 'レシピが見つかりませんでした' if @recipes.blank?
  end

  def show
  end

  def search
    @keywords = params[:keywords]
    unless @keywords.strip.empty?
      @recipes = Recipe.search_recipe_by_keywords(@keywords.strip)
    else
      flash.now[:warning] = '検索キーワードが入力されていません'
    end
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = current_user.recipes.new(recipe_params)
    if @recipe.save
      flash['notice'] = 'レシピを保存して公開しました。'
      redirect_to action: 'show', id: @recipe.id
    else
      render ('recipes/new')
    end
  end

  def edit
  end

  def update
    if @recipe.update(recipe_params)
      flash['notice'] = 'レシピを更新して公開しました。'
      redirect_to action: 'show', id: @recipe.id
    else
      render ('recipes/edit')
    end
  end

  def destroy
    @recipe.destroy!
    redirect_to root_path, notice: 'レシピを削除しました'
  end

  private
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    def recipe_params
      params
        .require(:recipe)
        .permit(
          Recipe::REGISTRABLE_ATTRIBUTES,
          recipe_ingredients_attributes: [RecipeIngredient::REGISTRABLE_ATTRIBUTES],
          recipe_steps_attributes:       [RecipeStep::REGISTRABLE_ATTRIBUTES,
            post_image_attributes:         [PostImage::REGISTRABLE_ATTRIBUTES]],
          post_image_attributes:         [PostImage::REGISTRABLE_ATTRIBUTES]
        )
    end
end
