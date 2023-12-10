class MessagesController < ApplicationController
  def create
    if Messenger.where(:user_id => current_user.id, :room_id => params[:message][:room_id]).present?
      message = Message.new(message_params)
      message.save
      redirect_to room_path(message.room_id)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def message_params
    params.require(:message).permit(:message, :user_id, :room_id)
  end

end
