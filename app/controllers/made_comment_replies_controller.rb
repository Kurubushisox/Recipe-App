class MadeCommentRepliesController < ApplicationController
  def create
    @made_comment_reply = MadeCommentReply.new(made_comment_reply_params)
    if @made_comment_reply.save
      redirect_to :back, notice: '作ったよレポートに返信しました'
    else
      redirect_to :back, alert: '返信を投稿できませんでした'
    end
  end

  def destroy
  end

  private
    def made_comment_reply_params
      params
      .require(:made_comment_reply)
      .permit(
        MadeCommentReply::REGISTRABLE_ATTRIBUTES,
      ).merge(
        user_id: current_user.id,
        made_comment_id: params[:made_comment_id]
      )
    end
end
