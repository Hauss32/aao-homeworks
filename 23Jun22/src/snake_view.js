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

        this.board.addFoodPos();
    }

    step() {
        this.board.snake.move();
        if ( this.board.isOver() ) {
            this.endGame();
            return;
        } else if ( this.didEatFood() ) {
            const $foodCell = this.findFoodCell();
            $foodCell.removeClass( 'food' );
            console.log('Ate food!');
            // TODO: grow snake
            this.board.addFoodPos();
        }

        this.draw();
    }

    didEatFood() {
        const snakeHead = this.board.snake.segments[0];
        if ( this.board.snake.equals(snakeHead, this.board.foodPos) ) {
            return true;
        } else {
            return false;
        }
    }

    endGame() {
        const $gameOver = $( '<h1>GAME OVER!</h1>' );
        $gameOver.addClass( 'game-over' );

        $( 'body' ).off( 'keydown' );
        this.$el.empty();
        this.$el.append( $gameOver );
        clearInterval( this.interval );
    }

    draw() {
        this.drawSnake();
        this.drawFood();
    }

    drawSnake() {
        const $snakeCells = this.getSnakeCells();

        $('.snake li.segment').removeClass( 'segment' );

        $snakeCells.each( function() {
            $( this ).addClass( 'segment' );
        })
    }

    drawFood() {
        const $foodCell = this.findFoodCell();
        $foodCell.addClass( 'food' );
    }

    findFoodCell() {
        if (this.board.foodPos) {
            const board = this.board;
            const $cells = $('.snake li');
            const $foodCell = $cells.filter(function () {
                const cellPos = $(this).data('pos');
                return board.snake.equals(cellPos, board.foodPos);
            });

            return $foodCell.first();
        }
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