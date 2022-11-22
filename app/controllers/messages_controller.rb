class MessagesController < ApplicationController
  def show
    @user = User.find(message_params['id'])
    room_name = get_room_name(current_user, @user)
    @room = Room.find_by_name(room_name)
    @messages = @room.messages
  end

  def create
    @user = User.find(message_params['id'])
    room_name = get_room_name(current_user, @user) || params[:name]
    @room = Room.find_by_name(room_name) || Room.create_private_room([@user, current_user], room_name)
    @messages = current_user.messages.create(body: message_params['body'], room: @room)
  end

  private

  def message_params
    params.require(:message).permit(:body, :id)
  end

  def get_room_name(user1, user2)
    user = [user1, user2].sort
    "private_#{user[0].id}_#{user[1].id}"
  end
end
