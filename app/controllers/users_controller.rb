class UsersController < ApplicationController
  before_action :set_filial
  before_action :set_user, only: %i[ show edit update destroy edit_password]

  def index
    @users = @filial.users.order(:name)
  end

  def show
  end

  def new
    @user = @filial.users.new
  end

  def edit
  end

  def edit_password; end

  def create
    @user = @filial.users.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to user_url(@user), notice: "Usuário foi criado com sucesso." }
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
        format.html { redirect_to user_url(@user), notice: "Usuário foi atualizado com sucesso." }
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
      format.html { redirect_to users_url, notice: "Usuário foi deletado com sucesso." }
      format.json { head :no_content }
    end
  end

  private
    def set_user
      @user = @filial.users.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :role, :email, :password, :password_confirmation)
    end
end
