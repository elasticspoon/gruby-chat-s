class AddUsersReferenceToChatRooms < ActiveRecord::Migration[7.1]
  def change
    add_reference :chat_rooms, :user, foreign_key: true
  end
end
