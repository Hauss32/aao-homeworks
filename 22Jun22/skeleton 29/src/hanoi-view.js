const Game = require('./game');

class View {
    constructor(game, $el) {
        this.game = game;
        this.$el = $el;
        this.currTowerIdx;

        this.setupTowers();
        this.render();
        this.bindClicks();
    }

    setupTowers() {
        const numTowers = 3;

        for (let i = 0; i < numTowers; i++) {
            const $tower = $( '<ul></ul>' );
            $tower.data( 'towerNum', i );
            $tower.addClass( 'unclicked' )
            this.$el.append( $tower );
        }
    }

    render() {
        const towerState = this.game.towers;
        const $viewTowers = this.$el.children('ul');

        $viewTowers.empty();

        towerState.forEach( (tower, towerIdx) => {
            tower.forEach( diskSize => {
                const $disk = $( '<li></li>' );
                const $viewTower = $( $viewTowers[towerIdx] );
                $disk.addClass( `size-${diskSize}` );
                $viewTower.prepend($disk);
            })
        });
    }

    bindClicks() {
        const view = this;
        const $viewTowers = this.$el.children('ul');
        const addClickHandler = (viewTower) => {
            const $viewTower = $(viewTower);

            $viewTower.click(function () {
                const $this = $(this);
                const towerNumIdx = $this.data('towerNum');
                if (view.currTowerIdx >= 0) {
                    view.tryMove(towerNumIdx);
                    view.currTowerIdx = undefined;
                    $viewTowers.removeClass('clicked');
                    $viewTowers.addClass('unclicked');
                } else {
                    view.currTowerIdx = towerNumIdx;
                    $this.addClass('clicked');
                    $this.removeClass('unclicked');
                }

                if (view.game.isWon()) {
                    setTimeout( () => {
                        alert("SOLVED!! You're so awesome! *sarcastic clap*");
                        view.finishGame();
                    }, 10);
                } 

                view.render();
            });
        }

        $viewTowers.each( function() {
            addClickHandler( $(this) );
        } );
    }

    tryMove(toTowerIdx) {
        const fromTowerIdx = this.currTowerIdx;
        const isValid = this.game.isValidMove(fromTowerIdx, toTowerIdx);

        if ( isValid ) {
            this.game.move( fromTowerIdx, toTowerIdx );
        } else {
            alert('Invalid move. Disks can only move to columns that are empty or' +
                ' have a larger disk on top than the disk being moved.');
        }
    }

    finishGame() {
        const $viewTowers = this.$el.children('ul');
        $viewTowers.off('click');
        $viewTowers.addClass('disabled');
    }
}

module.exports = View;