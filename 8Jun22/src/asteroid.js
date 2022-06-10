const Util = require('./utils');
const MovingObject = require('./moving_object');
const Ship = require('./ship');
const Bullet = require('./bullet');

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
Asteroid.COLOR = 'rgba(95, 74, 61, .95)';

Util.inherits(Asteroid, MovingObject);

Asteroid.prototype.collideWith = function (otherObj) {
    if (otherObj instanceof Ship) {
        otherObj.relocate();
    } else if (otherObj instanceof Bullet) {
        this.game.remove(this);
        this.game.remove(otherObj);
    }
}


module.exports = Asteroid;