const APIUtil = require("./api_util");

class InfiniteTweets {
    constructor() {
        this.$feedContainer = $( '.infinite-tweets' ).first();
        this.$fetchMoreBtn = $( '.fetch-more' ).first();
        this.minCreatedAt;

        this.handleFetchMore();
        this.$fetchMoreBtn.trigger( 'click' );
    }

    handleFetchMore() {
        this.$fetchMoreBtn.on( 'click', event => {
            event.preventDefault();
            const $tweetsContainer = $( '#feed' );
            const LIMIT = 20;

            this.$fetchMoreBtn.prop( 'disabled', true);

            APIUtil.fetchTweets(this.minCreatedAt)
                .then( tweets => {
                    this.$fetchMoreBtn.prop( 'disabled', false );

                    tweets.forEach( (tweet, idx) => {
                        
                        const $tweet = this.createTweetElem( tweet );
                        $tweetsContainer.append( $tweet );

                        if( idx === tweets.length - 1) {
                            this.minCreatedAt = tweet.created_at;
                        }

                    })

                    if( tweets.length < LIMIT ) {
                        this.$fetchMoreBtn.remove();
                    }
                })
        })
    }

    createTweetElem(data) {
        const $tweet = $('<li></li>');

        const $content = $( '<p class="content"></p>' );
        $content.html( data.content );

        const $mentions = this.createMentionsElem( data.mentions );

        const $user = $( '<a class="created-by"></a>');
        $user.attr( 'href', `/users/${data.user.id}`);
        $user.html( data.user.username );

        const $createdTime = $( '<time></time>' );
        $createdTime.html( data.created_at );
        $createdTime.attr( 'datetime', data.created_at );

        $tweet.append( $content );
        $tweet.append( $mentions );
        $tweet.append( $user );
        $tweet.append( $createdTime );

        return $tweet;
    }

    createMentionsElem(mentionsJSON) {
        const $mentions = $( '<ul class="mentions"></ul>' );

        mentionsJSON.forEach( mention => {
            const $mention = $( '<li></li>' );
            const $link = $( '<a></a>');
            $link.html( mention.user.username );
            $link.attr( 'href', `users/${mention.user.id}` );

            $mention.append( $link );
            $mentions.append( $mention );
        })

        return $mentions;
    }
}

module.exports = InfiniteTweets;