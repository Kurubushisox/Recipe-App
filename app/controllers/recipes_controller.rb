class RecipesController < ApplicationController

  def index
    @recipes = Recipe.limit(20).order("created_at DESC")
    flash.now[:warning] = 'レシピが見つかりませんでした' if @recipes.blank?
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Form::Recipe.new
  end

  def create
    @recipe = Form::Recipe.new(recipe_params)
    if @recipe.save
      flash['notice'] = 'レシピを保存して公開しました。'
      redirect_to action: 'show', id: @recipe.id
    else
      render ('recipes/new')
    end
  end

  def edit
    @recipe = Form::Recipe.find(params[:id])
  end

  def update
    @recipe = Form::Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      flash['notice'] = 'レシピを更新して公開しました。'
      redirect_to action: 'show', id: @recipe.id
    else
      render ('recipes/edit')
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy!
    redirect_to root_path, notice: 'レシピを削除しました'
  end

  private
    def recipe_params
      params
        .require(:form_recipe)
        .permit(
          Form::Recipe::REGISTRABLE_ATTRIBUTES,
          recipe_ingredients_attributes: [Form::RecipeIngredient::REGISTRABLE_ATTRIBUTES],
          recipe_steps_attributes: [Form::RecipeStep::REGISTRABLE_ATTRIBUTES,
                                    post_image_attributes: [Form::PostImage::REGISTRABLE_ATTRIBUTES]],
          post_image_attributes: [Form::PostImage::REGISTRABLE_ATTRIBUTES]
        )
    end
end
