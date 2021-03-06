class RecipesController < ApplicationController
  before_action :authenticate_user!, except: %i(index show search)
  before_action :set_recipe, only: %i(show edit update destroy)

  def index
    @recipes = Recipe.limit(100).order('created_at DESC').page(params[:page]).per(10)
    flash.now[:warning] = 'レシピが見つかりませんでした' if @recipes.blank?
  end

  def show
  end

  def search
    @keywords = params[:keywords]
    unless @keywords.strip.empty?
      @recipes = Recipe.search_recipe_by_keywords(@keywords.strip).page(params[:page]).per(10)
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
    unless @recipe.user == current_user
      redirect_to root_url
      return
    end
    if @recipe.update(recipe_params)
      flash['notice'] = 'レシピを更新して公開しました。'
      redirect_to action: 'show', id: @recipe.id
    else
      render ('recipes/edit')
    end
  end

  def destroy
    unless @recipe.user == current_user
      redirect_to root_url
      return
    end
    @recipe.destroy!
    redirect_to root_url, notice: 'レシピを削除しました'
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
