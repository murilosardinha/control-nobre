class ProductPricePolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def edit?
    user.admin?
  end
  
  def update?
    user.admin?
  end
end