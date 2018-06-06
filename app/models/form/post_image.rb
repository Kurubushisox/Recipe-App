class Form::PostImage < PostImage
  REGISTRABLE_ATTRIBUTES = %i(id image _destroy)
  belongs_to :imageable, polymorphic: true

# :imageをアップロードされたファイル本体に置き換える
# :mime_typeを設定する
  def image=(param)
    mime_type = param.content_type
    binary    = param.read

    write_attribute(:mime_type, mime_type)
    write_attribute(:image, binary)
  end
end
