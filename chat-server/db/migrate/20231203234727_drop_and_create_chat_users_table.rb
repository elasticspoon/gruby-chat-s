class DropAndCreateChatUsersTable < ActiveRecord::Migration[7.1]
  def change
    drop_table :chat_room_users
    create_table :chat_room_users do |t|
      t.references :user, null: false, foreign_key: true
      t.references :chat_room, null: false, foreign_key: true

      t.timestamps
    end
  end
end