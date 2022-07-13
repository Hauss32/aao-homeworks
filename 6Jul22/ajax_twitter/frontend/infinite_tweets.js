const APIUtil = require("./api_util");
const SharedUtil = require("./shared");

class InfiniteTweets {
    constructor() {
        this.$feedContainer = $( '.infinite-tweets' ).first();
        this.$feedList = $('#feed');
        this.$fetchMoreBtn = $( '.fetch-more' ).first();
        this.minCreatedAt;

        this.handleFetchMore();
        this.handleInsertTweet();
        this.$fetchMoreBtn.trigger( 'click' );
    }

    handleFetchMore() {
        this.$fetchMoreBtn.on( 'click', event => {
            event.preventDefault();
            const LIMIT = 20;

            this.$fetchMoreBtn.prop( 'disabled', true);

            APIUtil.fetchTweets(this.minCreatedAt)
                .then( tweets => {
                    this.$fetchMoreBtn.prop( 'disabled', false );

                    tweets.forEach( (tweet, idx) => {
                        
                        const $tweet = SharedUtil.createTweetElem( tweet );
                        this.$feedList.append( $tweet );

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

    handleInsertTweet() {
        this.$feedContainer.on( 'insert-tweet', (event, data) => {
            const $tweet = SharedUtil.createTweetElem(data);

            this.$feedList.prepend( $tweet );
        })
    }
}

module.exports = InfiniteTweets;