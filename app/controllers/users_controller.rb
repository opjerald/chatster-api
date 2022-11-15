class UsersController < ApplicationController
  before_action :authenticate_user!
  respond_to :json

  def index
    @users = User.all_except(current_user)
  end
end
