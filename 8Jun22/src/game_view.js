const Game = require("./game");

function GameView(ctx) {
    this.game = new Game(ctx);
    this.ctx = ctx;
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
}

GameView.prototype.start = function () {
    this.bindKeyHandlers();
    setInterval( () => {
        this.game.draw(this.ctx);
        this.game.step();
    }, 20);
}


module.exports = GameView;