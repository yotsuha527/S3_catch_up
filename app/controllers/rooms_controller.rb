class RoomsController < ApplicationController
  def create
    @room = Room.create(user_id: current_user.id)
    @messenger1 = Messenger.create(:room_id => @room.id, :user_id => current_user.id)
    @messenger2 = Messenger.create(params.require(:messenger).permit(:user_id, :room_id).merge(:room_id => @room.id))
    redirect_to room_path(@room.id)

    p @room
    p @messenger1
    p @messenger2

  end

  def show
    @room = Room.find(params[:id])
    @messages = @room.messages
    @message = Message.new
    @messengers = @room.messengers

    p @messengers
  end
end
