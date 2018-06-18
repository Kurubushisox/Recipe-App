class MadeCommentsController < ApplicationController
  def create
    @made_comment = MadeComment.new(
      user_id:   current_user.id,
      recipe_id: params[:recipe_id],
      content:   params[:made_comment][:content]
    )
    if @made_comment.save
      redirect_to :back, notice: '作ったよレポートを投稿しました'
    else
      redirect_to :back, alert: '作ったよレポートを投稿できませんでした。'
    end
  end

  def destroy
  end
end
