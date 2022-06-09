const Asteroid = require("./asteroid");
const Util = require("./utils");

function Game(ctx) {
    this.asteroids = [];
    this.ctx = ctx;

    this.addAsteroids();
}

Game.prototype.randomPos = function () {
    const width = 800;
    const height = 500;
    const randX = Math.floor( Math.random() * width);
    const randY = Math.floor( Math.random() * height);

    return [randX, randY];
}

Game.prototype.addAsteroids = function () {
    for(let i = 0; i < Game.NUM_ASTEROIDS; i++) {
        let asteroid = new Asteroid( this.randomPos() );
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

Game.DIM_X = 0;
Game.DIM_Y = 0;
Game.NUM_ASTEROIDS = 20;


module.exports = Game;