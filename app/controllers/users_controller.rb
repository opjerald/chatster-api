class UsersController < ApplicationController
  before_action :authenticate_user!
  respond_to :json

  def index
    # @users = User.all_except(current_user)
    @users = []
    @rooms = Room.where('name LIKE ?', "private_%#{current_user.id}%")
    @rooms.each do |room|
      @users << room.participants.except_user(current_user).user
    end
    @users
  end

  def show
    @user = User.find(params[:id])
  end
end
