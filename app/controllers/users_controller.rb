class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  def show
  end

  def like_recipes
    @recipes = current_user.liked_recipes.page(params[:page]).per(10)
  end

  private
    def set_user
      @user = User.find(params[:id])
    end
end
