const Util = require('./utils');
const MovingObject = require('./moving_object');

function Asteroid(pos) {
    MovingObject.call(this, {
        radius: Asteroid.RADIUS,
        color: Asteroid.COLOR
    });

    this.pos = pos;
    this.vel = Util.randomVec(5);
    
}

Asteroid.RADIUS = 20;
Asteroid.COLOR = '#625146';

Util.inherits(Asteroid, MovingObject);


module.exports = Asteroid;