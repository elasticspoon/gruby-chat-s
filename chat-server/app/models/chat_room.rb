class ChatRoom < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :messages, dependent: :destroy

  after_create_commit do
    broadcast_append_to "chat_rooms"
  end
  after_update_commit do
    broadcast_update_to "chat_rooms"
    broadcast_update_to self
  end
  after_destroy_commit { broadcast_remove_to "chat_rooms" }
end
