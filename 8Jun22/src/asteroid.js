const Util = require('./utils');
const MovingObject = require('./moving_object');

function Asteroid(options) {
    MovingObject.call(this, {
        radius: Asteroid.RADIUS,
        color: Asteroid.COLOR,
        game: options.game,
        pos: options.pos
    });

    this.vel = Util.randomVec(1);
}

Asteroid.RADIUS = 20;
Asteroid.COLOR = '#625146';

Util.inherits(Asteroid, MovingObject);


module.exports = Asteroid;