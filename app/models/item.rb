class Item < ApplicationRecord
  belongs_to :machine
  has_many :similars 
end
