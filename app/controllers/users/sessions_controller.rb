# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, options={})
    render json: {
      success: true,
      message: 'Signed in successfully',
      data: current_user
    }, status: :ok
  end

  def respond_to_on_destroy
    header = request.headers['Authorization']
    token = header.split(' ').last if header

    begin
      decoded = JWT.decoded(token, ENV['SECRET_KEY']).first
      current_user = User.find(decoded['sub'])

      if current_user
        render json: { success: true, message: 'Signed out successfully' }, status: :ok
      else
        render json: { success: false, message: 'Error while signing out' }, status: :unprocessable_entity
      end
    rescue ActiveRecord::RecordNotFound => e
      render json: { success: false, message: e.message }, status: :unauthorized
    rescue JWT::DecodeError
      render json: { success: false, message: 'No active token on the session' }, status: :unauthorized
    end
  end
end
