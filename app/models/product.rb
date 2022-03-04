class Product < ApplicationRecord
  require 'barby'
  require 'barby/barcode/code_128'
  require 'barby/outputter/png_outputter'

  belongs_to :filial
  after_create :set_code

  validates_uniqueness_of :code, scope: :filial_id

  def set_code
    return if code.present?
    
    code_id = rand.to_s[2..14]
    update(code: code_id)
  end

  def barcode
    code128 = Barby::Code128.new(code).to_png(height: 40, margin: 1)
    image = Base64.encode64(code128.to_s).gsub(/\s+/, "")

    "data:image/png;base64,#{Rack::Utils.escape(image)}"
  end
end
