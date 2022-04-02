class UsersController < ApplicationController
  before_action :load_user, only: [:edit, :update]

  def index
    @users = User.all if current_user.administrador?

    @users = User.all.active
  end

  def edit; end

  def update
    return unless @user.id == current_user.id || current_user.administrador?

    if @user.update(user_params)
      redirect_to users_path, notice: "Usuário #{@user.full_name || @user.email} atualizado com sucesso."
    else
      render :edit, alert: 'Ops, ocorreu um erro.'
    end
  end

  def become_admin
    current_user.become_admin

    redirect_to users_path, notice: 'Agora você é um administrador'
  end

  private

  def load_user
    @user = User.find(params[:id])
  end

  def user_params
    params.required(:user).permit(:first_name, :last_name, :email, :role)
  end
end