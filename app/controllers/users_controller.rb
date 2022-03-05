class UsersController < ApplicationController
  before_action :authorize_user!
  before_action :set_current_filial
  before_action :set_user, only: %i[ edit update destroy edit_password]

  def index
    @users = User.order(:filial_id, :role, :name)
  end

  def new
    @user = User.new(role: :employee)
  end

  def edit; end

  def edit_password; end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to filial_users_path(@filial), notice: "Usuário foi criado com sucesso." 
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    return redirect_to filial_users_path(@filial), notice: "Usuário foi atualizado com sucesso." if @user.update(user_params)

    if current_user.admin? 
      redirect_to filial_users_path(@filial), alert: "Usuário não pode ser atualizado."
    else
      redirect_to edit_password_user_path(@filial), alert: @user.errors.full_messages
    end
  end

  def destroy
    return redirect_to filial_users_path(@filial), notice: "Usuário foi deletado com sucesso." if @user.destroy

    redirect_to filial_users_path(@filial), alert: "Usuário não pode ser deletado."
  end

  private
    def authorize_user!
      authorize :user
    end

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :role, :filial_id, :email, :password, :password_confirmation)
    end
end
