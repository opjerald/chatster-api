class ApplicationController < ActionController::API
  before_action :configure_permitted_parameters, if: :devise_controller?

  def get_room_name(users)
    user = users.sort
    "private_#{user[0]}_#{user[1]}"
  end

  helper_method :get_room_name

  protected
  def configure_permitted_parameters
    added_attrs = %i[username email password password_confirmation has_image image]
    devise_parameter_sanitizer.permit(:sign_up, keys: added_attrs)
    devise_parameter_sanitizer.permit(:account_update, keys: added_attrs)
  end
end
