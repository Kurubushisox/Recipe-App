class PostImagesController < ApplicationController
  def new
    @post_image = PostImage.new
  end
  def create
    parent = 0
    mime = params[:post_image][:image].content_type
    image = params[:post_image][:image].read

    @post_image = PostImage.new(parent: parent, mime_type: mime, image: image)


    if @post_image.save
      flash[:notice] = 'ファイルを保存しました'
    else
      flash[:notice] = 'ファイルを保存できませんでした。'
      redirect_to :new_post_image
    end
  end
  def show
    @post_image = PostImage.find(params[:id])
      send_data @post_image.image, type: @post_image.mime_type, disposition: 'inline'
  end

private
  def post_image_params
    params.require(:post_image).permit(:image)
  end

end
