class PostImage < ActiveRecord::Base
  REGISTRABLE_ATTRIBUTES = %i(id image _destroy)
  belongs_to :imageable, polymorphic: true
  before_save :resize_image_and_set_mime_type

# :imageをアップロードされたファイル本体に置き換える
  def image=(param)
    binary    = param.read
    write_attribute(:image, binary)
  end

private
  def resize_image_and_set_mime_type
    require "mini_magick"

    image_size = '100x100'
    mime_type   = ''

    image = MiniMagick::Image.read(self.image)

    case self.imageable_type
      when 'User'
        image_size = '600x600>'
      when 'Recipe'
        image_size = '800x800>'
      when 'RecipeStep'
        image_size = '600x600>'
      when 'MadeComment'
        image_size = '800x800>'
      else
        return false
    end

    case image.type
      when 'JPEG'
        mime_type = 'image/jpeg'
      when 'PNG'
        mime_type = 'image/png'
      when 'GIF'
        mime_type = 'image/gif'
      else
        return false
    end

    image.resize image_size
    write_attribute(:image, image.to_blob)
    write_attribute(:mime_type, mime_type)
  end
end
