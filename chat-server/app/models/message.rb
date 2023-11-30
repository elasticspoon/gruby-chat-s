class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chat_room
  after_create_commit do
    broadcast_append_to(:room, chat_room, target: "messages")
  end
end
