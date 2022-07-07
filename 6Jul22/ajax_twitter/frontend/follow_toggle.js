const APIUtil = require( './api_util' );

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