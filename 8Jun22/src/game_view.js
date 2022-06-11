const Game = require("./game");

function GameView(ctx) {
    this.game = new Game(ctx);
    this.ctx = ctx;
    this.lastTime = 0;
}

GameView.prototype.bindKeyHandlers = function () {
    //key global from Keymaster lib
    key('up, w', () => {
        this.game.ship.power([0, -1]);
    });

    key('down, s', () => {
        this.game.ship.power([0, 1]);
    });

    key('left, a', () => {
        this.game.ship.power([-1, 0]);
    });

    key('right, d', () => {
        this.game.ship.power([1, 0]);
    });

    key('space', () => {
        this.game.ship.fireBullet();
    });
}

GameView.prototype.animate = function (currTime) {
    let timeDelta = currTime - this.lastTime;
    this.game.step(timeDelta);
    this.game.draw();
    this.lastTime = currTime;
    
    requestAnimationFrame( this.animate.bind(this) );
}

GameView.prototype.start = function () {
    this.bindKeyHandlers();
    requestAnimationFrame( this.animate.bind(this) );
}


module.exports = GameView;