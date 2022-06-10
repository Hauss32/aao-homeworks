const Util = require("./utils");
const MovingObject = require("./moving_object");

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



module.exports = Ship;