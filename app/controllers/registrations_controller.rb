# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController
  before_action :authenticate_user!, only: [:update_image]
  respond_to :json

  def update_image
    if current_user.update_without_password(account_update_params)
      render json: {
        success: true,
        data: current_user
      }, status: :ok
    else
      render json: {
        success: false,
        message: "Error while updating image"
      }
    end
  end

  private

  def respond_with(resource, options={})
    if resource.persisted?
      render json: {
        success: true,
        message: 'Signed up successfully',
        data: current_user
      }, status: :ok
    else
      render json: {
        success: false,
        message: 'Error on signing up',
        errors: resource.errors.full_messages
      }, status: :unprocessable_entity
    end
  end
end
