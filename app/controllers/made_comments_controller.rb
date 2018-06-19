class MadeCommentsController < ApplicationController
  def create
    @made_comment = MadeComment.new(made_comment_params)
    if @made_comment.save
      redirect_to :back, notice: '作ったよレポートを投稿しました'
    else
      redirect_to :back, alert: '作ったよレポートを投稿できませんでした。'
    end
  end

  def destroy
  end

  private
    def made_comment_params
      params
      .require(:made_comment)
      .permit(
        MadeComment::REGISTRABLE_ATTRIBUTES,
        post_image_attributes:[PostImage::REGISTRABLE_ATTRIBUTES]
      ).merge(
        user_id: current_user.id,
        recipe_id: params[:recipe_id]
      )
    end
end
