class DamagedItem < ApplicationRecord
  belongs_to :filial

  validates_uniqueness_of :title
end
