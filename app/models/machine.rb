class Machine < ApplicationRecord
  belongs_to :filial
  has_many :items, dependent: :destroy
  has_many :similars, through: :items
end
