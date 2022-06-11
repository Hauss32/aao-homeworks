const Asteroid = require("./asteroid");
const Ship = require("./ship");
const Util = require("./utils");

function Game(ctx) {
    this.asteroids = [];
    this.bullets = [];
    this.ship = new Ship( { game: this, pos: this.randomPos() } );
    this.ctx = ctx;

    this.addAsteroids();
    this.addImg();
}

Game.DIM_X = 800;
Game.DIM_Y = 500;
Game.NUM_ASTEROIDS = 5;
Game.BG_IMG_SRC = "../dist/space.png";

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

Game.prototype.allObjects = function () {
    return this.asteroids
                .concat(this.ship)
                .concat(this.bullets);
}

Game.prototype.addImg = function () {
    const img = new Image();
    img.src = Game.BG_IMG_SRC;
    this.bgImg = img;
}

Game.prototype.drawImg = function () {
    this.bgImg.onload = () => {
        this.ctx.drawImage(this.bgImg, 0, 0);
    };
}

Game.prototype.draw = function () {
    Util.clearCanv(this.ctx);
    this.ctx.drawImage(this.bgImg, 0, 0, Game.DIM_X, Game.DIM_X);
    this.allObjects().forEach( obj => obj.draw(this.ctx) );
}

Game.prototype.moveObjects = function (timeDelta) {
    this.allObjects().forEach( obj => obj.move(timeDelta) );
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
    const allObjects = this.allObjects();
    for (let i = 0; i < allObjects.length; i++) {
        const obj = allObjects[i];

        for (let j = 0; j < allObjects.length; j++) {
            const otherObj = allObjects[j];

            if (obj === otherObj) {
                continue;
            } else {
                if ( obj.isCollidedWith(otherObj) ) {
                    obj.collideWith(otherObj);
                }
            }
        }
    }
}

Game.prototype.step = function (timeDelta) {
    this.moveObjects(timeDelta);
    this.checkCollisions();
}

Game.prototype.remove = function (obj) {
    let arrToDeleteFrom;

    if (obj instanceof Asteroid) {
        arrToDeleteFrom = this.asteroids;
    } else {
        arrToDeleteFrom = this.bullets;
    }

    const objIdx = arrToDeleteFrom.findIndex( ele => ele === obj );
    arrToDeleteFrom.splice(objIdx, 1);
}

Game.prototype.isOutOfBounds = function (pos) {
    const [ currX, currY ] = pos;
    const invalidX = (currX < 0 || currX > Game.DIM_X) ? true : false;
    const invalidY = (currY < 0 || currY > Game.DIM_Y) ? true : false;

    return invalidX || invalidY;
}


module.exports = Game;