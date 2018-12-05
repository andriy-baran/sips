class RegistrationsController < Devise::RegistrationsController

  private

  def sign_up_params
    params.require(:user).permit(:full_name, :phone, :email, :password, :password_confirmation, :avatar, :rate_per_hour)
  end

  def account_update_params
    params.require(:user).permit(:full_name, :phone, :email, :password, :password_confirmation, :avatar, :rate_per_hour)
  end
end