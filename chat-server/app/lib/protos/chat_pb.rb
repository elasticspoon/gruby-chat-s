# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: chat.proto

require 'google/protobuf'

Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file("chat.proto", :syntax => :proto3) do
    add_message "rpc.ChatMessage" do
      optional :id, :int32, 1
      optional :user_id, :int32, 2
      optional :chat_room_id, :int32, 3
      optional :chat_message, :string, 4
      optional :created_at, :string, 5
      optional :updated_at, :string, 6
    end
    add_message "rpc.ErrorCode" do
      optional :code, :int32, 1
    end
  end
end

module Rpc
  ChatMessage = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("rpc.ChatMessage").msgclass
  ErrorCode = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("rpc.ErrorCode").msgclass
end
