const MessageStore = require("./message_store");

const Compose = {
    render: () => {
        const container = document.createElement( 'div' );

        container.className = 'new-message';
        container.innerHTML = Compose.renderForm();

        container.addEventListener( 'change', (event) => {
            const draftField = event.target.name;
            const value = event.target.value;
            
            MessageStore.updateDraftField( draftField, value );
        })

        container.addEventListener( 'submit', (event) => {
            event.preventDefault();

            MessageStore.sendDraft();
            window.location.hash = '#inbox';
        })

        return container;
    },

    renderForm: () => {
        const messageDraft = MessageStore.getMessageDraft();
        const htmlStr = `
            <p class="new-message-header">New Message</p>
            <form class="compose-form">
                <input 
                    type="text" 
                    placeholder="Recipient" 
                    name="to"
                    value="${messageDraft.to}">
                </input>
                <input 
                    type="text" 
                    placeholder="Subject" 
                    name="subject"
                    value="${messageDraft.subject}">
                </input>
                <textarea name="body" rows="20">${messageDraft.body}</textarea>
                <button type="submit" class="btn btn-primary submit-message">Send</button>
            </form>
            `

        return htmlStr;
    }
}

module.exports = Compose;