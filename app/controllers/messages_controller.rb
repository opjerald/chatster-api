class MessagesController < ApplicationController
  def show
    users = "{#{current_user.id}, #{params[:id]}}"
    @messages = Message.where("users @> ?", users)
  end

  def create
    users = [current_user.id.to_i, message_params['to'].to_i].sort
    @message = Message.new(body: message_params['body'], users: users, user: current_user)
  end

  private

  def message_params
    params.require(:message).permit(:to, :body)
  end
end
