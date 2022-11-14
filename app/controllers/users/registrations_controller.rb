# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

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
