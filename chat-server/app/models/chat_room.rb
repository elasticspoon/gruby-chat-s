class ChatRoom < ApplicationRecord
  has_many :users
  has_many :messages, dependent: :destroy

  after_create_commit { broadcast_append_to "chat_rooms", target: "chat_rooms", partial: "chat_rooms/chat_room", locals: {chat_room: self} }
end
