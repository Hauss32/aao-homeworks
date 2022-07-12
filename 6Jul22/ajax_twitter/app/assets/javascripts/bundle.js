/******/ (() => { // webpackBootstrap
/******/ 	var __webpack_modules__ = ({

/***/ "./frontend/api_util.js":
/*!******************************!*\
  !*** ./frontend/api_util.js ***!
  \******************************/
/***/ ((module) => {

const APIUtil = {
    followUser: id => {
        return $.ajax({
            url: `/users/${id}/follow`,
            type: 'POST',
            dataType: 'json'
        });
    },

    unfollowUser: id => {
        return $.ajax({
            url: `/users/${id}/follow`,
            type: 'DELETE',
            dataType: 'json'
        });
    },

    searchUsers: queryStr => {
        return $.ajax({
            url: `/users/search`,
            type: 'GET',
            dataType: 'json',
            data: {
                query: queryStr
            }
        });
    },

    composeTweet: (json) => {
        return $.ajax({
            url: `/tweets`,
            type: 'POST',
            dataType: 'json',
            data: json
        });
    },

    fetchTweets: createdAtFilter => {
        return $.ajax({
            url: `/feed`,
            type: 'GET',
            dataType: 'json',
            data: {
                max_created_at: createdAtFilter
            }
        });
    }

};

module.exports = APIUtil;

/***/ }),

/***/ "./frontend/follow_toggle.js":
/*!***********************************!*\
  !*** ./frontend/follow_toggle.js ***!
  \***********************************/
/***/ ((module, __unused_webpack_exports, __webpack_require__) => {

const APIUtil = __webpack_require__( /*! ./api_util */ "./frontend/api_util.js" );

class FollowToggle {
    constructor(el, options) {
        this.$el = $( el );
        this.userId = this.$el.data( 'user-id' ) || options.userId;
        this.followState = this.$el.data( 'initial-follow-state' ) || options.followState;

        this.render();
        this.handleClick();
    }

    render () {
        const text = ( this.followState === 'followed') ? 'Unfollow!' : 'Follow!';
        this.$el.text( text );
        this.$el.prop( "disabled", false );
    }

    handleClick () {
        this.$el.on( 'click', event => {
            event.preventDefault();

            this.$el.prop( "disabled", true );

            if( this.followState === 'followed' ) {
                APIUtil.unfollowUser
                    .call( this, this.userId )
                    .then( () => {
                        this.followState = 'unfollowed';
                        this.render();
                } );
            } else {
                APIUtil.followUser
                    .call( this, this.userId )
                    .then( () => {
                        this.followState = 'followed' 
                        this.render();
                } );
            }
        })
    }
}

module.exports = FollowToggle;

/***/ }),

/***/ "./frontend/infinite_tweets.js":
/*!*************************************!*\
  !*** ./frontend/infinite_tweets.js ***!
  \*************************************/
/***/ ((module, __unused_webpack_exports, __webpack_require__) => {

const APIUtil = __webpack_require__(/*! ./api_util */ "./frontend/api_util.js");

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

/***/ }),

/***/ "./frontend/tweet_compose.js":
/*!***********************************!*\
  !*** ./frontend/tweet_compose.js ***!
  \***********************************/
/***/ ((module, __unused_webpack_exports, __webpack_require__) => {

const APIUtil = __webpack_require__(/*! ./api_util */ "./frontend/api_util.js");

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

/***/ }),

/***/ "./frontend/users_search.js":
/*!**********************************!*\
  !*** ./frontend/users_search.js ***!
  \**********************************/
/***/ ((module, __unused_webpack_exports, __webpack_require__) => {

const APIUtil = __webpack_require__(/*! ./api_util */ "./frontend/api_util.js");
const FollowToggle = __webpack_require__(/*! ./follow_toggle */ "./frontend/follow_toggle.js");

class UsersSearch {
    constructor(el) {
        this.$el = $( el );
        this.$input = this.$el.find( 'input' );
        this.$ul = this.$el.find('ul.users');

        this.handleInput();
    }

    render(users) {
        this.$ul.empty();

        users.forEach( user => {
            const $listItem = $( '<li></li>');
            const $listLink = $( '<a></a>' );
            const linkURL = `/users/${user.id}`;
            const followBtn = new FollowToggle('<button></button>', {
                userId: user.id,
                followState: ( user.followed ) ? 'followed' : 'unfollowed'
            })

            followBtn.$el.addClass( 'follow-toggle' );

            $listLink.attr("href", linkURL);
            $listLink.text( user.username );

            $listItem.append( $listLink );

            $listItem.append( followBtn.$el );

            this.$ul.append( $listItem );
        });
    }

    handleInput() {
        const search = this;

        search.$input.on( 'input', function() {
            const searchStr = search.$input.val();

            APIUtil.searchUsers( searchStr )
                .then( users => {
                    search.render( users );
                })
        } );
    }
}

module.exports = UsersSearch;

/***/ })

/******/ 	});
/************************************************************************/
/******/ 	// The module cache
/******/ 	var __webpack_module_cache__ = {};
/******/ 	
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/ 		// Check if module is in cache
/******/ 		var cachedModule = __webpack_module_cache__[moduleId];
/******/ 		if (cachedModule !== undefined) {
/******/ 			return cachedModule.exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = __webpack_module_cache__[moduleId] = {
/******/ 			// no module.id needed
/******/ 			// no module.loaded needed
/******/ 			exports: {}
/******/ 		};
/******/ 	
/******/ 		// Execute the module function
/******/ 		__webpack_modules__[moduleId](module, module.exports, __webpack_require__);
/******/ 	
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/ 	
/************************************************************************/
var __webpack_exports__ = {};
// This entry need to be wrapped in an IIFE because it need to be isolated against other modules in the chunk.
(() => {
/*!*****************************!*\
  !*** ./frontend/twitter.js ***!
  \*****************************/
const FollowToggle = __webpack_require__( /*! ./follow_toggle */ "./frontend/follow_toggle.js");
const InfiniteTweets = __webpack_require__(/*! ./infinite_tweets */ "./frontend/infinite_tweets.js");
const TweetCompose = __webpack_require__(/*! ./tweet_compose */ "./frontend/tweet_compose.js");
const UsersSearch = __webpack_require__( /*! ./users_search */ "./frontend/users_search.js");

$( () => {
    const $followBtns = $( 'button.follow-toggle' );
    $followBtns.each( function() {
        new FollowToggle( this );
    })

    const $userSearches = $( 'nav.users-search' );
    $userSearches.each(function () {
        new UsersSearch(this);
    })

    new TweetCompose();
    new InfiniteTweets();
})
})();

/******/ })()
;
//# sourceMappingURL=bundle.js.map