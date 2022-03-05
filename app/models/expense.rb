class Expense < ApplicationRecord
  belongs_to :filial

  before_save :set_date

  def set_date
    self.date ||= Date.today 
  end
end
