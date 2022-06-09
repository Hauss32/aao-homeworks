const Game = require("./game");

function GameView(ctx) {
    this.game = new Game(ctx);
    this.ctx = ctx;
}

GameView.prototype.start = function () {
    setInterval( () => {
        this.game.draw(this.ctx);
        this.game.moveObjects();
    }, 20);
}

module.exports = GameView;