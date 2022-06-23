class View {
    constructor(board, $el) {
        this.board = board;
        this.$el = $el;
        this.setupBoard();
        this.draw();
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
}

View.BOARD_WIDTH = 21;

module.exports = View;