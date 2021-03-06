const MovingObject = require('./moving_object');
const Asteroid = require('./asteroid');
const Game = require('./game');
const Util = require('./utils');
const GameView = require('./game_view');

window.MovingObject = MovingObject;

window.addEventListener('DOMContentLoaded', (event) => {
    const canv = document.getElementById('game-canvas');
    const ctx = canv.getContext("2d");
    const gameView = new GameView(ctx);
    window.canv = canv;
    // window.ctx = ctx;

    gameView.start(ctx);
});