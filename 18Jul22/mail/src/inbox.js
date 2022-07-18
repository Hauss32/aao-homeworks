const MessageStore = require("./message_store");

const Inbox = {
    render: () => {
        const messages = MessageStore.getInboxMessages();
        const messageContainer = document.createElement( 'ul' );
        messageContainer.className = 'messages';

        messages.forEach( message => {
            const msgElem = Inbox.renderMessage( message );
            messageContainer.appendChild( msgElem );
        })

        return messageContainer;
    },

    renderMessage: (message) => {
        const msgElem = document.createElement('li');
        msgElem.className = 'message';

        msgElem.innerHTML = `
            <span class='from'>${message.from}</span>
            <span class="subject">${message.subject}</span> -
            <span class="body">${message.body}</span>
            `
        return msgElem;
    }
}

module.exports = Inbox;