const FollowToggle = require( './follow_toggle');
const UsersSearch = require( './users_search');

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