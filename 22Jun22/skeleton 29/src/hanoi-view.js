const Game = require('./game');

class View {
    constructor(game, $el) {
        this.game = game;
        this.$el = $el;

        this.setupTowers();
        this.bindEvents();
    }

    setupTowers() {
        const numTowers = 3;
        const towerHeight = 3;
        let $firstTower;

        for (let i = 0; i < numTowers; i++) {
            const $tower = $( '<ul></ul>' );
            $tower.data( 'towerNum', i );
            $tower.addClass( 'unclicked' )
            this.$el.append( $tower );
            if ( i === 0 ) {
                $firstTower = $tower;
            }
        }

        for (let j = 1; j <= towerHeight; j++) {
            const $piece = $( '<li></li>' );
            $piece.addClass( `size-${j}` );
            $firstTower.append( $piece );
        }
    }

    bindEvents() {
        const $lists = this.$el.children('ul');
        this.$el.on( 'click', 'ul', function () {
            $lists.removeClass( 'clicked' );
            $lists.addClass( 'unclicked' );
            $( this ).addClass( 'clicked' );
            $( this ).removeClass( 'unclicked' );
        } );
    }
}

module.exports = View;