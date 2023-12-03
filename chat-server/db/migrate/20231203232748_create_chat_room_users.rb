class CreateChatRoomUsers < ActiveRecord::Migration[7.1]
  def change
    drop_table :chat_rooms_users
    create_table :chat_room_users do |t|
      t.references :users, null: false, foreign_key: true
      t.references :chat_rooms, null: false, foreign_key: true

      t.timestamps
    end
  end
end
