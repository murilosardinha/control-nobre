class Product < ApplicationRecord
  require 'barby'
  require 'barby/barcode/code_128'
  require 'barby/outputter/png_outputter'

  belongs_to :filial
  after_create :set_code

  def set_code
    return unless code.present?

    self.code = id.to_s.rjust(13, '0')
  end

  def barcode
    code128 = Barby::Code128.new(code).to_png(height: 40, margin: 1)
    image = Base64.encode64(code128.to_s).gsub(/\s+/, "")

    "data:image/png;base64,#{Rack::Utils.escape(image)}"
  end
end
