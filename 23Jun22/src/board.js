class Board {
    constructor(snake, $el) {
        this.snake = snake;
        this.$el = $el;
    }
}

Board.NUM_CELLS_WIDE = 21;

module.exports = Board;