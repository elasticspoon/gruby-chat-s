class ChatRoom < ApplicationRecord
  has_many :chat_room_users, dependent: :destroy
  has_many :users, -> { distinct }, through: :chat_room_users
  # has_many :users, -> { distinct }, through: :chat_room_users, after_remove: :removed_user, after_add: :added_user
  has_many :messages, dependent: :destroy

  after_create_commit do
    broadcast_append_to "chat_rooms"
  end

  after_destroy_commit { broadcast_remove_to "chat_rooms" }

  private

  def removed_user
    broadcast_replace_to self
  end

  def added_user
    broadcast_replace_to self
  end
end
