class RoomsController < ApplicationController
  
  def index
    @rooms = []
    @parcitipated = current_user.participants
    @parcitipated.each do |p|
      unless p.room.is_private
        @rooms << p.room
      end
    end
    @rooms
  end
  
  def show
    @room = Room.find(params[:id])
  end

  def create
    @room = Room.create(name: params[:name])
  end

  def create_private
    @user = User.find[params[:user_id]]
    @room = Room.create_private_room([current_user, @user])
  end
end
