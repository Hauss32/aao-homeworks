const APIUtil = require("./api_util");

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
                        
                        const $tweet = this.createTweetElem( tweet );
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
            const $tweet = this.createTweetElem(data);

            this.$feedList.prepend( $tweet );
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