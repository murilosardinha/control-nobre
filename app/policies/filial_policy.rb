class FilialPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    user.admin? && user.filial.matriz?
  end

  def new?
    user.admin? && user.filial.matriz?
  end

  def edit?
    user.admin? && user.filial.matriz?
  end

  def create?
    user.admin? && user.filial.matriz?
  end

  def update?
    user.admin? && user.filial.matriz?
  end

  def destroy?
    user.admin? && user.filial.matriz?
  end
end