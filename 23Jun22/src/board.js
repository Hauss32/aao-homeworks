class Board {
    constructor(snake) {
        this.snake = snake;
        this.foodPos;

        this.addFoodPos();
    }

    isOver() {
        return this.isInvalid() || this.snake.isCollided();
    }

    isInvalid() {
        const [xPos, yPos] = this.snake.snakeHeadPos();
        if (xPos >= Board.NUM_CELLS_WIDE || xPos < 0 || yPos >= Board.NUM_CELLS_WIDE || yPos < 0) {
            return true;
        }

        return false;
    }

    addFoodPos() {
        const randX = Math.floor( (Math.random() * Board.NUM_CELLS_WIDE) );
        const randY = Math.floor( (Math.random() * Board.NUM_CELLS_WIDE) );
        const foodPos = [ randX, randY ];

        if ( this.isEmpty(foodPos) ) {
            this.foodPos = foodPos;
        } else {
            this.addFoodPos();
        }
    }

    isEmpty(pos) {
        for (let i = 0; i < this.snake.segments.length; i++) {
            const segment = this.snake.segments[i];
            if ( this.snake.equals( pos, segment.position ) ) {
                return false;
            }
        }

        return true;
    }
}

Board.NUM_CELLS_WIDE = 21;

module.exports = Board;