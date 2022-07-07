class Destination < ApplicationRecord
  belongs_to :filial
  has_many :sales, dependent: :nullify

  validates_uniqueness_of :name, scope: :filial_id

  enum status: {active: 1, inactive: 2}

  def codename
    return "#{name} - #{operador}" unless operador.blank?
    
    "#{name}"
  end
end
