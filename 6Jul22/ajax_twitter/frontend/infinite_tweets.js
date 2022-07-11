const APIUtil = require("./api_util");

class InfiniteTweets {
    constructor() {
        this.$feedContainer = $( '.infinite-tweets' ).first();
        this.$fetchMoreBtn = $( '.fetch-more' ).first();
        this.minCreatedAt;

        this.handleFetchMore();
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
                        const $tweet = $( '<li></li>');
                        $tweet.html( this.createTweetElem(tweet) );
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
        return JSON.stringify(data);
    }
}

module.exports = InfiniteTweets;