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
})
})();

/******/ })()
;
//# sourceMappingURL=bundle.js.map