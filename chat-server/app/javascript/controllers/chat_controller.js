import { Controller } from "@hotwired/stimulus";
import consumer from "channels/consumer";

// Connects to data-controller="chat"
export default class extends Controller {
  static targets = ["messages", "input", "typingUsers"];
  static values = { roomId: Number, userId: Number };

  initialize() {
    this.channel;
    this.typingUsers = new Set();
    this.timeoutId;
  }

  scrollToBot() {
    let height = this.messagesTarget.getBoundingClientRect().height;
    this.messagesTarget.scrollTo(0, height);
  }

  connect() {
    this.joinRoom();
    this.scrollToBot();
    this.inputTarget.addEventListener("input", this.userIsTyping.bind(this));
    document.addEventListener("user_is_typing", (e) => {
      if (e.detail.user_is_typing) {
        this.typingUsers.add(e.detail.user);
      } else {
        this.typingUsers.delete(e.detail.user);
      }
      console.log(e, this.typingUsers);
      this.updateTypingUsers();
    });
  }

  joinRoom() {
    this.channel = consumer.subscriptions.create(
      { channel: "ChatRoomChannel", room: this.roomIdValue },
      {
        connected() {},

        disconnected() {},

        received(data) {
          if (data.hasOwnProperty("user_is_typing")) {
            let e = new CustomEvent("user_is_typing", {
              detail: {
                user: data.user,
                user_is_typing: data.user_is_typing,
              },
            });
            document.dispatchEvent(e);
          }
        },
      },
    );
  }

  userIsTyping() {
    if (!this.timeoutId) {
      this.channel.send({ user_id: this.userIdValue, user_is_typing: true });
    }

    clearTimeout(this.timeoutId);
    this.timeoutId = setTimeout(() => {
      this.channel.send({ user_id: this.userIdValue, user_is_typing: false });
      this.timeoutId = null;
    }, 2000);
  }

  updateTypingUsers() {
    if (this.typingUsers.size > 0) {
      this.typingUsersTarget.innerHTML = `${Array.from(this.typingUsers).join(
        ", ",
      )} is typing...`;
    } else {
      this.typingUsersTarget.innerHTML = "";
    }
  }
}
