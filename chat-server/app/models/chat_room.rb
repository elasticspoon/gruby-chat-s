class ChatRoom < ApplicationRecord
  has_many :chat_room_users, dependent: :destroy
  has_many :users, through: :chat_room_users
  has_many :messages, dependent: :destroy

  after_create_commit do
    broadcast_append_to "chat_rooms"
  end
  after_update_commit do
    broadcast_replace_to self
  end
  after_destroy_commit { broadcast_remove_to "chat_rooms" }
end
