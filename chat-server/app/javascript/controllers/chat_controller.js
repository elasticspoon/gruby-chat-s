import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="chat"
export default class extends Controller {
  static targets = ["messages", "input"];

  initialize() {}

  scrollToBot() {
    let height = this.messagesTarget.getBoundingClientRect().height;
    this.messagesTarget.scrollTo(0, height);
  }

  connect() {
    let obs = new MutationObserver(this.scrollToBot);
    let target = this.messagesTarget;
    obs.observe(target, { childList: true });

    this.scrollToBot();
  }
}
