import { Controller } from "@hotwired/stimulus";
import consumer from "channels/consumer";

// Connects to data-controller="chat"
export default class extends Controller {
  static targets = ["messages", "input"];
  static values = { roomId: Number };

  initialize() {}

  scrollToBot() {
    let height = this.messagesTarget.getBoundingClientRect().height;
    this.messagesTarget.scrollTo(0, height);
  }

  connect() {
    this.joinRoom();
    this.scrollToBot();
  }

  joinRoom() {
    consumer.subscriptions.create({
      channel: "ChatRoomChannel",
      room: this.roomIdValue,
    });
  }
}
// consumer.subscriptions.create(
//   { channel: "ChatRoomChannel", room: this.roomIdValue },
//   {
//     connected() {},
//
//     disconnected() {},
//
//     received(data) {
//       // Called when there's incoming data on the websocket for this channel
//     },
//   },
// );
