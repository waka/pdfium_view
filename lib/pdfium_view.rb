require "pdfium_view/version"
require 'pdfium'

module PdfiumView
  class Railties < ::Rails::Railtie
    initializer 'pdfium_view' do
      ActiveSupport.on_load :action_controller do
        ActionController::Renderers.add :pdfium do |obj, options|
          filename = options[:filename]
          page_num = options[:page_num]

          pdf = PDFium::Document.new(filename)
          page = pdf.page_at(page_num)

          # return A4 size
          send_data page.as_image(height: 1048).data(:png),
            filename: filename,
            type: 'image/png',
            disposition: 'inline',
            stream: 'true',
            buffer_size: '4096'
        end
      end
    end 
  end
end
