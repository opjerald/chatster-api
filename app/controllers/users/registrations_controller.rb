# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  respond_to :json

  # protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email, :password, :password_confirmation])
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  private

  def respond_with(resource, options={})
    if resource.persisted?
      render json: {
        success: true,
        message: 'Signed up successfully'
      }, status: :ok
    else
      render json: {
        success: false,
        message: 'Error on signing up'
      }, status: :unprocessable_entity
    end
  end
end
