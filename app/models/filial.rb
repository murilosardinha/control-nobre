class Filial < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :products, inverse_of: :filial, dependent: :destroy
  has_many :expenses, dependent: :destroy
  has_many :machines, dependent: :destroy
  
  has_many :sales, dependent: :destroy
  has_many :destinations, dependent: :destroy
  
  enum category: { matriz: 1, branch: 2 }
  scope :main, ->() { matriz.first }

  def first_name
    "#{name.split.first}"
  end
end
