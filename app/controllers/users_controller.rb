class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  def show
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params
        .require(:user)
        .permit(
          User::REGISTRABLE_ATTRIBUTES,
          post_image_attributes [PostImage::REGISTRABLE_ATTRIBUTES]
        )
end
