class Filial < ApplicationRecord
  has_many :users
  has_many :products, inverse_of: :filial
  has_many :expenses
  has_many :machines
  
  has_many :sales
  has_many :destinations
  
  accepts_nested_attributes_for :products, reject_if: :all_blank, allow_destroy: true

  enum category: { matriz: 1, branch: 2 }

  def first_name
    "#{name.split.first}"
  end
end
