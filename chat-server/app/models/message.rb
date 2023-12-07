class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chat_room
  after_create_commit do
    broadcast_prepend_to(:room, chat_room, target: "messages")
  end

  def to_proto
    Rpc::ChatMessage.new(
      id: id.to_i,
      user_id: user_id.to_i,
      chat_room_id: chat_room_id.to_i,
      chat_message: content,
      created_at: created_at.to_s,
      updated_at: updated_at.to_s
    )
  end
end
