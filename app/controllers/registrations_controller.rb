# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController
  respond_to :json

  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  private

  def respond_with(resource, options={})
    if resource.persisted?
      render json: {
        success: true,
        data: resource
      }, status: :ok
    else
      render json: {
        success: false,
        errors: resource.errors.full_messages
      }, status: :unprocessable_entity
    end
  end
end
