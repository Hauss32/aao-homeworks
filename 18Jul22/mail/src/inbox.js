const Inbox = {
    render: function() {
        const messageContainer = document.createElement( 'ul' );
        messageContainer.className = 'messages';
        messageContainer.innerHTML = 'An inbox message';

        return messageContainer;
    }
}

module.exports = Inbox;