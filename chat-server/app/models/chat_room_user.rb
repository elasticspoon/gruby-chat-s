class ChatRoomUser < ApplicationRecord
  belongs_to :user
  belongs_to :chat_room

  after_create_commit do
    chat_room.broadcast_replace_to chat_room
  end

  after_destroy_commit do
    chat_room.broadcast_replace_to chat_room
  end
end
