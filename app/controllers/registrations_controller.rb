class RegistrationsController < Devise::RegistrationsController
  private

  def account_update_params
    params.require(:user).permit(
      :firstname,
      :lastname,
      :email,
      :gender,
      :mobile_number,
      :current_password,
      :password,
      :password_confirmation
    )
  end
end
