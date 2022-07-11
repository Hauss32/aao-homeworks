const APIUtil = require("./api_util");

class TweetCompose {
    constructor() {
        this.$form = $( '.tweet-compose' ).first();
        this.$allMentions = $( '.all-mentions' ).first();

        this.handleSubmit();
        this.handleCharLimit();
        this.handleAddMention();
        this.handleRemoveMention();
    }

    handleSubmit() {
        const $form = this.$form;

        $form.on( 'submit', event => {
            const $inputs = $form.find( ':input' );
            const jsonData = $form.serializeJSON();
            event.preventDefault();

            $inputs.each(function () {
                $( this ).prop( 'disabled', true );
            });

            APIUtil.composeTweet( jsonData )
                .then( (data) => {
                    $inputs.each(function () {
                        $( this ).prop( 'disabled', false );
                    });

                    const $fields = $inputs.filter( 'select, textarea' );
                    $fields.each(function () {
                        $( this ).val('');
                    });

                    this.$allMentions.empty();

                    const $newTweet = $( '<li></li>' );
                    $newTweet.html( `${data.content} -- ` );

                    const $newTweetLink = $('<a></a>');
                    const userUrl = `/users/${data.user_id}`
                    $newTweetLink.html( data.user.username );
                    $newTweetLink.attr( "href", userUrl );

                    $newTweet.append( $newTweetLink );
                    $newTweet.append( ` -- ${data.created_at}` );

                    const $feed = $('#feed');
                    $feed.prepend( $newTweet );

                } )
        });
    }

    handleCharLimit() {
        const $messageInput = this.$form.find('textarea').first();
        const $charCounter = this.$form.find( '.chars-left' ).first();
        const CHAR_LIMIT = 140;
        
        $messageInput.on( 'input', function() {
            const tweetStr = $messageInput.val();
            const charsRemaining = CHAR_LIMIT - Math.min(CHAR_LIMIT, tweetStr.length);
            const charsRemainingStr = `${charsRemaining} chars remain`;

            $charCounter.html( charsRemainingStr );

            if ( charsRemaining === 0 ) {
                $messageInput.val( tweetStr.slice(0, CHAR_LIMIT) );
            }
        })
    }

    handleAddMention() {
        const $addMentionBtn = $( '.add-mention' ).first();

        $addMentionBtn.on( 'click', () => {
            const $mentionSelect = this.newUserSelect();
            this.$allMentions.append( $mentionSelect );
        })
    }

    handleRemoveMention() {
        this.$form.on( 'click', 'a.remove-mentioned-user', function(event) {
            event.preventDefault();
            $(this).parent().remove();
        })
    }

    newUserSelect() {
        const $mentionContainer = $( '<div class="mention-container"></div>');
        const $mentionSelect = $( '<select name="tweet[mentioned_user_ids][]"></select>' );
        const $placeholderOption = $( '<option selected disabled>Select a User...</option>');
        const $mentionDelete = $( '<a href="#" class="remove-mentioned-user">🗑️</a>' );

        $mentionContainer.append( $mentionSelect );
        $mentionSelect.append( $placeholderOption );
        $mentionContainer.append( $mentionDelete );

        window.users.forEach( user => {
            const $option = $( '<option></option>' );
            $option.val( user.id );
            $option.html( user.username );

            $mentionSelect.append( $option );
        })

        return $mentionContainer;
    }
}

module.exports = TweetCompose;