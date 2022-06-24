class Board {
    constructor(snake) {
        this.snake = snake;
    }

    isOver() {
        return this.isInvalid() || this.snake.isCollided();
    }

    isInvalid() {
        const [xPos, yPos] = this.snake.segments[0];
        if (xPos >= Board.NUM_CELLS_WIDE || xPos < 0 || yPos >= Board.NUM_CELLS_WIDE || yPos < 0) {
            return true;
        }

        return false;
    }
}

Board.NUM_CELLS_WIDE = 21;

module.exports = Board;