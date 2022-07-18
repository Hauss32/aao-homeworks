const MessageStore = require("./message_store");

const Sent = {
    render: () => {
        const messages = MessageStore.getSentMessages();
        const messageContainer = document.createElement('ul');
        messageContainer.className = 'messages';

        messages.forEach(message => {
            const msgElem = Sent.renderMessage(message);
            messageContainer.appendChild(msgElem);
        })

        return messageContainer;
    },

    renderMessage: (message) => {
        const msgElem = document.createElement('li');
        msgElem.className = 'message';

        msgElem.innerHTML = `
            <span class='from'>${message.to}</span>
            <span class="subject">${message.subject}</span> -
            <span class="body">${message.body}</span>
            `
        return msgElem;
    }
}

module.exports = Sent;