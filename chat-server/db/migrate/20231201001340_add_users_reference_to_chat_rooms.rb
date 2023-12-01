class AddUsersReferenceToChatRooms < ActiveRecord::Migration[7.1]
  def change
    create_table :chat_rooms_users, id: false do |t|
      t.belongs_to :user
      t.belongs_to :chat_room
    end
  end
end
