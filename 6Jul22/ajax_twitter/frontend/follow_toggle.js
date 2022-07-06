class FollowToggle {
    constructor(el) {
        this.$el = $( el );
        this.userId = this.$el.data( 'user-id' );
        this.followState = this.$el.data( 'initial-follow-state' );

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

            const url = `/users/${this.userId}/follow`;
            const type = ( this.followState === 'followed' ) ? 'DELETE' : 'POST';
            const toggleState = () => {
                const newState = (this.followState === 'followed' ) ? 'unfollowed' : 'followed';
                this.followState = newState;
                this.render();
            }

            $.ajax( {
                url: url,
                type: type,
                dataType: 'json',
                success: toggleState
            } );
        })
    }
}

module.exports = FollowToggle;