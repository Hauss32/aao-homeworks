const Util = require("./utils");
const MovingObject = require("./moving_object");
const Bullet = require("./bullet");

function Ship(options) {
    MovingObject.call(this, {
        color: Ship.COLOR,
        radius: Ship.RADIUS,
        game: options.game,
        pos: options.pos,
        vel: [0,0]
    });

}

Ship.COLOR = '#6E7FAA';
Ship.RADIUS = 15;

Util.inherits(Ship, MovingObject);

Ship.prototype.relocate = function () {
    this.pos = this.game.randomPos();
};

Ship.prototype.power = function (impulse) {
    const [ addVelX, addVelY] = impulse;
    this.vel[0] += addVelX;
    this.vel[1] += addVelY;
}

Ship.prototype.fireBullet = function () {
    const bullet = new Bullet( {
        pos: this.pos,
        vel: this.vel,
        game: this.game
    });

    this.game.bullets.push(bullet);
}



module.exports = Ship;