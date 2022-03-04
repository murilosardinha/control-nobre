class UsersController < ApplicationController
  before_action :authorize_user!
  before_action :set_current_filial
  before_action :set_user, only: %i[ show edit update destroy edit_password]

  def index
    @users = User.order(:filial_id, :role, :name)
  end

  def show
  end

  def new
    @user = User.new(role: :employee)
  end

  def edit
  end

  def edit_password; end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to filial_users_path(@filial), notice: "Usuário foi criado com sucesso." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to filial_users_path(@filial), notice: "Usuário foi atualizado com sucesso." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to filial_users_path(@filial), notice: "Usuário foi deletado com sucesso." }
      format.json { head :no_content }
    end
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
