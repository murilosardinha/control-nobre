class Machine < ApplicationRecord
  belongs_to :filial
  has_many :items
end
