class MessagesController < ApplicationController
  before_action :authenticate_user!
  
  def create

    if message_params['room_id']
      @room = Room.find(message_params['room_id'])
    elsif message_params['user_id']
      room_name = get_room_name([current_user.id, message_params['user_id'].to_i])
      @room = Room.find_by_name(room_name) || Room.create_private_room([current_user.id], message_params['user_id'].to_i)
    end

    @message = current_user.messages.create(body: message_params['body'], room: @room)
  end

  private

  def message_params
    params.require(:message).permit(:body, :room_id, :user_id)
  end
end
