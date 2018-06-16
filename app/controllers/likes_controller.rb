class LikesController < ApplicationController
  before_action :set_like, only: %i(create destroy)
  def create
    if @like.blank?
      Like.create(
        user_id: current_user.id,
        recipe_id: params[:recipe_id]
      )
    end
    redirect_to :back
  end

  def destroy
    @like.destroy if @like.present?
    redirect_to :back
  end

  private
    def set_like
      @like = Like.find_by(
        user_id: current_user.id,
        recipe_id: params[:recipe_id]
      )
    end

end
