class ProductPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    true
  end

  def new?
    user.admin?
  end

  def edit?
    user.admin?
  end

  def edit_limited?
    true
  end

  def create?
    user.admin?
  end

  def update?
    true
  end

  def destroy?
    user.admin?
  end
end