class ChatRoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_room_#{params[:room]}"

    logger.info "User #{current_user.name} subscribed to chat_room_#{params[:room]}"
    chat_room = ChatRoom.find(params[:room])
    chat_room&.update(users: chat_room.users.push(current_user).uniq)
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
