class Segment {
    constructor(position, direction) {
        this.position = position;
        this.direction = direction; 
    }

    move(nextDirection) {
        const [xPos, yPos] = this.position;
        const [xMove, yMove] = this.direction;
        const xNewPos = xPos + xMove;
        const yNewPos = yPos + yMove;

        this.direction = nextDirection;
        this.position = [ xNewPos, yNewPos ];
    }
}

module.exports = Segment;