class Product < ApplicationRecord
  require 'barby'
  require 'barby/barcode/code_128'
  require 'barby/outputter/png_outputter'

  belongs_to :filial
  has_many :sale_products, dependent: :destroy
  has_many :sales, through: :sale_products, dependent: :destroy

  after_create :set_code

  validates_uniqueness_of :code, scope: :filial_id
  validates :code, length: {minimum: 13, maximum: 13}, allow_blank: true

  delegate :name, to: :filial, prefix: true
  scope :in_stock, ->() { where("CAST(quantity AS integer) > ?", 0) }

  def set_code
    return if code.present?
    
    code_id = rand.to_s[2..14]
    update(code: code_id)
  end

  def codename
    "#{name} - #{reference}"
  end

  def fullname
    "#{codename} / #{code}"
  end

  def decrease_quantity(qtd)
    qtd = qtd.to_i
    result = self.quantity - qtd
    return 0 unless result >= 0
    
    update(quantity: result)
    qtd
  end

  def return_quantity(qtd)
    qtd = qtd.to_i

    update(quantity: self.quantity + qtd)
  end

  def barcode
    code128 = Barby::Code128.new(code).to_png(height: 40, margin: 1)
    image = Base64.encode64(code128.to_s).gsub(/\s+/, "")

    "data:image/png;base64,#{Rack::Utils.escape(image)}"
  end
end
