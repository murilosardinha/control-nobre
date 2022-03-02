class Filial < ApplicationRecord
  has_many :users
  has_many :products
  has_many :expenses
  has_many :machines

  def first_name
    "#{name.split.first}"
  end
end
