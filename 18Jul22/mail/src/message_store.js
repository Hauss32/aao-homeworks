const messages = {
    sent: [
        {
            to: "friend@mail.com",
            subject: "Check this out",
            body: "It's so cool"
        },
        { to: "person@mail.com", subject: "zzz", body: "so booring" }
    ],
    inbox: [
        {
            from: "grandma@mail.com",
            subject: "Fwd: Fwd: Fwd: Check this out",
            body:
                "Stay at home mom discovers cure for leg cramps. Doctors hate her"
        },
        {
            from: "person@mail.com",
            subject: "Questionnaire",
            body: "Take this free quiz win $1000 dollars"
        }
    ]
};

const messageDraft = new Message();

function Message(from='', to='', subject='', body='') {
    this.from = from;
    this.to = to;
    this.subject = subject;
    this.body = body;
}

const MessageStore = {
    getInboxMessages: function() {
        return messages.inbox;
    },

    getSentMessages: function() {
        return messages.sent;
    },

    getMessageDraft: function() {
        return messageDraft;
    },

    updateDraftField: function(field, val) {
        messageDraft[field] = val;
    },

    sendDraft: function() {
        messages.sent.push( messageDraft );
        messageDraft = new Message();
    }
}

module.exports = MessageStore;