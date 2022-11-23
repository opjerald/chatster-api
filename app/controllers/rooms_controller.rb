class RoomsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @rooms = []
    @parcitipated = current_user.participants
    @parcitipated.each do |p|
      unless p.room.is_private
        @rooms << p.room
      end
    end
  end
  
  def show
    @room = Room.find(params[:id])
    @messages = @room.messages
  end

  def create
    @room = Room.create(name: params[:name])
  end
end
