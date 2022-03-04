class User < ApplicationRecord
  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  belongs_to :filial

  validates_presence_of :name

  enum role: { admin: 1, employee: 2 }

  delegate :name, to: :filial, prefix: true, allow_nil: true

  def first_name
    "#{name.split.first}"
  end
end
