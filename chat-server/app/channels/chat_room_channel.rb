class ChatRoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_room_#{params[:room]}"

    logger.info "User #{current_user.name} subscribed to chat_room_#{params[:room]}"
    chat_room = ChatRoom.find(params[:room])
    chat_room.users << current_user if chat_room
  end

  def unsubscribed
    stream_from "chat_room_#{params[:room]}"

    logger.info "User #{current_user.name} unsubscribed from chat_room_#{params[:room]}"
    ChatRoomUser.find_by(user: current_user, chat_room_id: params[:room]).destroy
  end
end
