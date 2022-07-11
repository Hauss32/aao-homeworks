const FollowToggle = require( './follow_toggle');
const InfiniteTweets = require('./infinite_tweets');
const TweetCompose = require('./tweet_compose');
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

    new TweetCompose();
    new InfiniteTweets();
})