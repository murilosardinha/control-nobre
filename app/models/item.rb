class Item < ApplicationRecord
  belongs_to :machine
  has_many :similars, dependent: :destroy
end
