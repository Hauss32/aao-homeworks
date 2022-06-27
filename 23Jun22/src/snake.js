const Segment = require('./segment');

class Snake {
    constructor() {
        this.segments = [ new Segment([ 10, 10], [ 0, 0 ]) ];
    }

    turn(dir) {
        this.changeHeadDirection( Snake.DIRECTIONS[dir] );
    }

    move() {
        let lastSegDir = this.segments[0].direction;
        
        this.segments.forEach( segment => {
            const currDir = segment.direction;
            segment.move( lastSegDir );
            lastSegDir = currDir;
        })
    }

    changeHeadDirection(dir) {
        this.segments[0].direction = dir;
        this.segments[0].nextDirection = dir;
    }

    segmentsIncludes(arr) {
        for (let i = 0; i < this.segments.length; i++) {
            const segmentArr = this.segments[i].position;
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

    isCollided() {
        if ( this.segments.length === 1 ) {
            return false;
        }

        const snakeHead = this.snakeHeadPos();
        const snakeBody = this.segments.slice( 1, this.segments.length -1 );

        for (let i = 0; i < snakeBody.length; i++) {
            if ( this.equals(snakeHead, snakeBody[i].position) ) {
                return true;
            }
        }

        return false;
    }

    snakeHeadPos() {
        return this.segments[0].position;
    }

    addSegment() {
        const newSegPos = this.newSegmentPos();
        const lastSegIdx = this.segments.length - 1;
        const lastSegDir = this.segments[lastSegIdx].direction;

        const newSeg = new Segment(newSegPos, lastSegDir);

        this.segments = this.segments.concat(newSeg);
    }

    newSegmentPos() {
        const lastSegIdx = this.segments.length - 1;
        const lastSeg = this.segments[lastSegIdx];
        const [ xPos, yPos ] = lastSeg.position;
        const [ xDir, yDir] = lastSeg.direction;
        const newXDir = xDir * -1;
        const newYDir = yDir * -1;

        return [ (xPos + newXDir), (yPos + newYDir) ];
    }
}

Snake.DIRECTIONS = {
    'U': [0, -1], 
    'D': [0, 1],
    'L': [-1, 0],
    'R': [1, 0]
};

module.exports = Snake;