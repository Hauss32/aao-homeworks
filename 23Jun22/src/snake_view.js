class View {
    constructor(board, $el) {
        this.board = board;
        this.$el = $el;
        this.setupBoard();
        this.bindKeydown();
        this.interval = setInterval( () => {
            this.step();
        }, 500);
    }

    setupBoard() {
        for (let i = 0; i < View.BOARD_WIDTH; i++) {
            const $ul = $( '<ul></ul>' );
            this.$el.append( $ul );

            for (let j = 0; j < View.BOARD_WIDTH; j++) {
                const $li = $( '<li></li>' );
                $li.data( 'pos', [ j, i ] );
                $ul.append( $li );
            }
        }
    }

    step() {
        this.board.snake.move();
        this.draw();
    }

    draw() {
        const $snakeCells = this.getSnakeCells();

        $('.snake li.segment').removeClass( 'segment' );

        $snakeCells.each( function() {
            $( this ).addClass( 'segment' );
        })
    }

    getSnakeCells() {
        const snake = this.board.snake;
        const $cells = $( '.snake li' );
        const $snakeCells = $cells.filter( function() {
            const $cell = $( this );
            const cellPos = $cell.data( 'pos' );
            return snake.segmentsIncludes( cellPos );
        });
        return $snakeCells;
    }

    bindKeydown() {
        $('body').on( 'keydown', event => {
            const direction = View.KEYMAP[event.keyCode];
            if ( direction ) {
                this.board.snake.turn(direction);
            }
        });
    }
}

View.BOARD_WIDTH = 21;
View.KEYMAP = {
    37: 'L',
    38: 'U',
    39: 'R',
    40: 'D'
}

module.exports = View;