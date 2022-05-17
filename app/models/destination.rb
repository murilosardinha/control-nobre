class Destination < ApplicationRecord
  belongs_to :filial
  has_many :sales, dependent: :nullify

  validates_uniqueness_of :name, scope: :filial_id

  def codename
    "#{name} / #{operador}"
  end
end
