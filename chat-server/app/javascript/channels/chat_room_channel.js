import consumer from "channels/consumer";

function JoinRoom(roomId) {
  console.log("JoinRoom", roomId);
  consumer.subscriptions.create(
    { channel: "ChatRoomChannel", room: roomId },
    {
      connected() {
        console.log("connected", roomId);
        // Called when the subscription is ready for use on the server
      },

      disconnected() {
        console.log("connected", roomId);
        // Called when the subscription has been terminated by the server
      },

      received(data) {
        // Called when there's incoming data on the websocket for this channel
      },
    },
  );
}

document.addEventListener("DOMContentLoaded", () => {
  console.log("DOMContentLoaded");
  let room = document.querySelector("[data-chat-room]");
  if (room) {
    JoinRoom(room.dataset.chatRoom);
  }
});
