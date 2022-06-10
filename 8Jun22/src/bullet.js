const MovingObject = require("./moving_object");
const Util = require("./utils");

function Bullet(options) {
    MovingObject.call(this, {
        color: Bullet.COLOR,
        radius: Bullet.RADIUS,
        pos: options.pos,
        vel: [options.vel[0] * 2, options.vel[1] * 2], //bullets will travel faster than ship
        game: options.game
    })

    this.vel = this.calcVel(options.vel);
}

Bullet.RADIUS = 5;
Bullet.COLOR = '#D35E5E';

Util.inherits(Bullet, MovingObject);

Bullet.prototype.draw = function (ctx) {
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

    ctx.beginPath();
    ctx.arc(
        this.pos[0],
        this.pos[1],
        2,
        0,
        2 * Math.PI
    );

    ctx.fillStyle = '#D3BE5E';
    ctx.fill();
}

Bullet.prototype.isWrappable = false;

Bullet.prototype.calcVel = function (vel) {
    const [ velX, velY ] = vel;
    const speedFactor = 4;

    if (velX === 0 && velY === 0) {
        return [speedFactor, 0] //give bullet initial velocity if ship isn't moving
    } else {
        let newVelX;
        const xDir = (velX < 0) ? -1 : 1;
        let newVelY;
        const yDir = (velY < 0) ? -1 : 1;

        //make bullets travel faster than ship
        (velX === 0) ? newVelX = velX : newVelX = velX + (xDir * speedFactor);
        (velY === 0) ? newVelY = velY : newVelY = velY + (yDir * speedFactor);
        return [ newVelX, newVelY ];
    }
}


module.exports = Bullet;