class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  has_many :chat_room_users, dependent: :destroy
  has_many :chat_rooms, through: :chat_room_users
  has_many :messages, dependent: :destroy

  def stream_location(room_id)
    client = Gruf::Client.new(service: ::Rpc::Chat, options: {hostname: "127.0.0.1:50051"})

    Thread.new do
      rsp = client.call(:GetLocation, user_id: id)

      puts "Received #{rsp.message.inspect}\n"
      rsp.message.each do |msg|
        ActionCable.server.broadcast("chat_room_#{room_id}", {
          user: email,
          location: msg.distance
        })
      end
    end
  end
end
