const APIUtil = require("./api_util");

class TweetCompose {
    constructor() {
        this.$form = $( '.tweet-compose' ).first();

        this.handleSubmit();
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
}

module.exports = TweetCompose;