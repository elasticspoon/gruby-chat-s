class ChatRoomsController < ApplicationController
  before_action :set_chat_room, only: %i[show destroy]
  before_action :authenticate_user!, only: %i[create destroy show]

  # GET /chat_rooms
  def index
    @chat_rooms = ChatRoom.all
  end

  # GET /chat_rooms/1
  # join the chat room
  def show
  end

  # POST /chat_rooms
  def create
    @chat_room = ChatRoom.new(chat_room_params)

    if @chat_room.save
      redirect_to @chat_room, notice: "Chat room was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # DELETE /chat_rooms/1
  def destroy
    @chat_room.destroy!
    redirect_to chat_rooms_url, notice: "Chat room was successfully destroyed.", status: :see_other
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_chat_room
    @chat_room = ChatRoom.includes(:messages).find(params[:id])
    @messages = @chat_room.messages
    @message = Message.new(chat_room_id: @chat_room.id, user: current_user)
  end

  # Only allow a list of trusted parameters through.
  def chat_room_params
    params.require(:chat_room).permit(:name)
  end
end
