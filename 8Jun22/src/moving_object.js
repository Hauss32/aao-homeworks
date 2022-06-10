function MovingObject(options) {
    this.pos = options.pos;
    this.vel = options.vel;
    this.radius = options.radius;
    this.color = options.color;
    this.game = options.game;
}

MovingObject.prototype.draw = function(ctx) {
    ctx.beginPath();
    ctx.arc(
        this.pos[0],
        this.pos[1],
        this.radius,
        0,
        2 * Math.PI
    );

    ctx.fillStyle = this.color;
    ctx.fill();
}

MovingObject.prototype.move = function() {
    const newX = this.pos[0] + this.vel[0];
    const newY = this.pos[1] + this.vel[1];

    this.pos = this.game.wrap([ newX, newY ]);
}

MovingObject.prototype.isCollidedWith = function (otherObject) {
    const diffX = (this.pos[0] - otherObject.pos[0]);
    const diffY = (this.pos[1] - otherObject.pos[1]);
    const dist = Math.sqrt(diffX ** 2 + diffY ** 2);
    const sumRadii = this.radius + otherObject.radius;

    return (dist < sumRadii) ? true : false;
}

MovingObject.prototype.collideWith = function (otherObj) {
    //by default, do nothing
}

module.exports = MovingObject;