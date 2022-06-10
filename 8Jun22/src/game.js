const Asteroid = require("./asteroid");
const Util = require("./utils");

function Game(ctx) {
    this.asteroids = [];
    this.ctx = ctx;

    this.addAsteroids();
}

Game.DIM_X = 800;
Game.DIM_Y = 500;
Game.NUM_ASTEROIDS = 5;

Game.prototype.randomPos = function () {
    const randX = Math.floor( Math.random() * Game.DIM_X);
    const randY = Math.floor( Math.random() * Game.DIM_Y);

    return [randX, randY];
}

Game.prototype.addAsteroids = function () {
    for(let i = 0; i < Game.NUM_ASTEROIDS; i++) {
        let asteroid = new Asteroid( { pos: this.randomPos(), game: this } );
        this.asteroids.push(asteroid);
    }
}

Game.prototype.draw = function () {
    Util.clearCanv(this.ctx);

    this.asteroids.forEach( asteroid => asteroid.draw(this.ctx) );
}

Game.prototype.moveObjects = function () {
    this.asteroids.forEach( asteroid => asteroid.move() );
}

Game.prototype.wrap = function (pos) {
    const [currX, currY] = pos;
    const maxX = Game.DIM_X;
    const maxY = Game.DIM_Y;
    const newPos = [];

    if(currX < 0 || currX > maxX){
        (currX < 0) ? newPos.push(currX + maxX) : newPos.push(currX - maxX);
    } else {
        newPos.push(currX);
    }

    if (currY < 0 || currY > maxY) {
        (currY < 0) ? newPos.push(currY + maxY) : newPos.push(currY - maxY);
    } else {
        newPos.push(currY);
    }

    return newPos;
}

Game.prototype.checkCollisions = function () {
    for (let i = 0; i < this.asteroids.length; i++) {
        const asteroid = this.asteroids[i];

        for (let j = 0; j < this.asteroids.length; j++) {
            const otherAsteroid = this.asteroids[j];

            if (asteroid === otherAsteroid) {
                continue;
            } else {
                if ( asteroid.isCollidedWith(otherAsteroid) ) {
                    asteroid.collideWith(otherAsteroid);
                }
            }
        }
    }
}

Game.prototype.step = function () {
    this.moveObjects();
    this.checkCollisions();
}

Game.prototype.remove = function (asteroid) {
    const astIdx = this.asteroids.findIndex( ele => ele === asteroid );
    this.asteroids.splice(astIdx, 1);
}


module.exports = Game;