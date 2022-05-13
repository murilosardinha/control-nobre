class Product < ApplicationRecord
  require 'barby'
  require 'barby/barcode/code_128'
  require 'barby/outputter/png_outputter'

  belongs_to :filial
  has_many :sale_products, dependent: :destroy
  has_many :sales, through: :sale_products, dependent: :destroy
  has_many :product_prices, inverse_of: :product, dependent: :destroy
  
  validates_uniqueness_of :code, scope: :filial_id
  validates :code, length: {minimum: 13, maximum: 13}, allow_blank: true
  
  after_create :set_code
  before_save :upcase_attrs

  enum category: { item: 1, epi: 2 }

  delegate :name, to: :filial, prefix: true
  scope :in_stock, ->() { where("CAST(quantity AS integer) > ?", 0) }

  def self.find_prices(code, quantity)
    product = Product.find_by(code: code, filial: Filial.main)
    product_prices = product.product_prices.in_stock
    return [{quantity: quantity, price: 0}] unless product_prices.any?

    prices = ProductPrice.find_prices(product_prices, quantity)
    prices.sort_by{|k| k['price']}.reverse
  end
  
  def set_code
    return if code.present?

    code_id = rand.to_s[2..14]
    update(code: code_id)
  end

  def upcase_attrs
    self.name = name.upcase
    self.product_code = product_code.upcase if product_code
  end

  def codename
    "#{name} - #{reference}"
  end

  def fullname
    "#{codename} / #{product_code} / #{code}"
  end

  def decrease_quantity(qtd)
    qtd = qtd.to_i
    current_quantity = self.quantity || 0

    result = current_quantity - qtd    
    return update(quantity: result) if result >= 0

    false
  end

  def increase_quantity(qtd)
    qtd = qtd.to_i
    current_quantity = self.quantity || 0

    update(quantity: current_quantity + qtd)
  end

  def barcode
    code128 = Barby::Code128.new(code).to_png(height: 40, margin: 1)
    image = Base64.encode64(code128.to_s).gsub(/\s+/, "")

    "data:image/png;base64,#{Rack::Utils.escape(image)}"
  end
end
