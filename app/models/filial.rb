class Filial < ApplicationRecord
  has_many :users
  has_many :products

  def first_name
    "#{name.split.first}"
  end
end
