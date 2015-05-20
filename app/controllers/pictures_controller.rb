class PicturesController < ApplicationController
  def create
    uploader = InlineImageUploader.new
    uploader.store!(params[:upload])

    response = "<script type='text/javascript'>
                 window.parent.CKEDITOR.tools.callFunction('#{params['CKEditorFuncNum']}', '#{uploader.url}');
               </script>"

    render text: response
  end
end
