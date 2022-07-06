const APIUtil = require('./api_util');

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

            $listLink.attr("href", linkURL);
            $listLink.text( user.username );

            $listItem.append( $listLink );

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