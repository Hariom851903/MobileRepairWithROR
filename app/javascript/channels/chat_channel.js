import consumer from "channels/consumer";

const chatChannel = consumer.subscriptions.create("ChatChannel", {
  connected() {
    console.log("Connected to the chat channel.");
    // You can add any initialization logic here
  },

  disconnected() {
    console.log("Disconnected from the chat channel.");
    // You can add any cleanup logic here
  },

  received(data) {
    console.log("Received data from the server:", data);
    // Handle the incoming data here, for example, update the UI
  }
});

// Example of sending data to the server
// Replace this with your actual logic for sending messages
function sendMessage(message) {
  chatChannel.send({ body: message });
}

export { sendMessage };

