class ApplicationController < ActionController::Base
  include Pundit

  layout 'application'
  before_action :authenticate_user!
  
  helper_method :current_filial
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def current_filial
    current_user.filial
  end

  def set_filial
    @filial = current_filial
  end

  def format_number(number)
    return 0 unless number.present?
    return number if number.class == Integer

    number.gsub(/\,/mi, '.').to_f
  end

  protected

  def pundit_user
    current_user
  end

  def authorize(record, query = nil)
    super(record, query)
  end

  def user_not_authorized
    flash[:alert] = "Usuário não autorizado!"
    redirect_to(request.referer || root_path)
  end
end
