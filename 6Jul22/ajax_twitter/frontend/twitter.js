const FollowToggle = require( './follow_toggle');

$( () => {
    const $followBtns = $( 'button.follow-toggle' );
    $followBtns.each( function() {
        const followToggle = new FollowToggle( this );
    })
})