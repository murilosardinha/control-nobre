class Destination < ApplicationRecord
  belongs_to :filial
  has_many :sales

  # def codename
  #   "#{name} / #{address}"
  # end
end
