const APIUtil = require("./api_util");

class TweetCompose {
    constructor() {
        this.$form = $( '.tweet-compose' ).first();

        this.handleSubmit();
        this.handleCharLimit();
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
}

module.exports = TweetCompose;