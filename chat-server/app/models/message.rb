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

  def self.from_proto(proto)
    Message.new(
      # message_id: proto.id,
      user_id: proto.user_id,
      chat_room_id: proto.chat_room_id,
      content: proto.chat_message,
      created_at: proto.created_at,
      updated_at: proto.updated_at
    )
  end
end
