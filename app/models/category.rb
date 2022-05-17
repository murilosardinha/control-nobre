class Category < ApplicationRecord
  has_many :sales, dependent: :nullify

  validates_presence_of :title
end
