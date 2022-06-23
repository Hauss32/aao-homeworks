class Snake {
    constructor() {
        this.direction = [ 0, 0 ];
        this.segments = [ [ 10, 10 ] ];
    }

    turn(dir) {
        this.direction = dir;
        this.move();
    }

    move() {
        const headLoc = this.segments[0];

        this.segments.forEach( seg => {
            this.moveSegment(seg);
        })
    }

    moveSegment(currLoc) {
        const [ xPos, yPos ] = currLoc;
        const [ xMove, yMove ] = this.direction;
        const xNewPos = xPos + xMove;
        const yNewPos = yPos + yMove;
        return [ xNewPos, yNewPos ];
    }
}

Snake.DIRECTIONS = {
    'U': [0, 1], 
    'D': [0, -1],
    'L': [-1, 0],
    'R': [1, 0]
};

module.exports = Snake;