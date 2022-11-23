class UsersController < ApplicationController
  before_action :authenticate_user!
  respond_to :json

  def index
    @users = []
    @rooms = Room.where('name LIKE ?', "private_%#{current_user.id}%")
    @rooms.each do |room|
      @users << room.participants.except_user(current_user).user
    end
  end

  def show
    @user = User.find(params[:id])
    @room = Room.find_by_name(get_room_name([current_user.id, @user.id]))
    @messages = @room ? @room.messages : []
  end
end
