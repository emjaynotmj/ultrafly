class RegistrationsController < Devise::RegistrationsController
  private
  def sign_up_params
    params.require(:user).permit(
      :email,
      :password,
      :password_confirmation
      )
  end

  def account_update_params
    params.require(:user).permit(
      :firstname,
      :lastname,
      :email,
      :gender,
      :phone_number,
      :current_password,
      :password,
      :password_confirmation
      )
  end
end