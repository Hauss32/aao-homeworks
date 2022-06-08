function MovingObject(options) {
    this.pos = options.pos;
    this.vel = options.vel;
    this.radius = options.radius;
    this.color = options.color;
    this.ctx = options.ctx;
}

MovingObject.prototype.draw = function() {
    this.ctx.beginPath();
    this.ctx.arc(
        this.pos[0],
        this.pos[1],
        this.radius,
        0,
        2 * Math.PI
    );

    this.ctx.fillStyle = this.color;
    this.ctx.fill();
}

MovingObject.prototype.move = function() {
    this.pos[0] += this.vel[0];
    this.pos[1] += this.vel[1];
}

module.exports = MovingObject;