class Snake {
    constructor() {
        this.direction = [ 0, 0 ];
        this.segments = [ [ 10, 10 ] ];
    }

    turn(dir) {
        this.direction = Snake.DIRECTIONS[dir];
    }

    move() {
        this.segments.forEach( (seg, idx) => {
            this.moveSegment(seg, idx);
        })
    }

    moveSegment(currLoc, idx) {
        const [ xPos, yPos ] = currLoc;
        const [ xMove, yMove ] = this.direction;
        const xNewPos = xPos + xMove;
        const yNewPos = yPos + yMove;
        this.segments[idx] = [ xNewPos, yNewPos ];
    }

    segmentsIncludes(arr) {
        for (let i = 0; i < this.segments.length; i++) {
            const segmentArr = this.segments[i];
            if ( this.equals(segmentArr, arr) ) {
                return true;
            }
        }

        return false;
    }

    equals(arr1, arr2) {
        if (arr1.length != arr2.length) {
            return false;
        } else {
            for (let i = 0; i < arr1.length; i++) {
                if (arr1[i] != arr2[i]) {
                    return false;
                }
            }
        }

        return true;
    }

    isOver() {
        return this.isInvalid() || this.isCollided();
    }

    isInvalid() {
        const [ xPos, yPos ] = this.segments[0];
        if ( xPos >= 21 || xPos < 0 || yPos >= 21 || yPos < 0 ) {
            return true;
        }

        return false;
    }

    isCollided() {
        if ( this.segments.length === 1 ) {
            return false;
        }

        const snakeHead = this.segments[0];
        const snakeBody = this.segments.slice( 1, this.segments.length -1 );

        for (let i = 0; i < snakeBody.length; i++) {
            if ( this.equals(snakeHead, snakeBody[i]) ) {
                return true;
            }
        }

        return false;
    }
}

Snake.DIRECTIONS = {
    'U': [0, -1], 
    'D': [0, 1],
    'L': [-1, 0],
    'R': [1, 0]
};

module.exports = Snake;