class Filial < ApplicationRecord
  has_many :users
  has_many :products
  has_many :expenses

  def first_name
    "#{name.split.first}"
  end
end
