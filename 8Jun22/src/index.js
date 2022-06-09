const MovingObject = require('./moving_object');
const Asteroid = require('./asteroid');
const Game = require('./game');
const Util = require('./utils');

window.MovingObject = MovingObject;

window.addEventListener('DOMContentLoaded', (event) => {
    const canv = document.getElementById('game-canvas');
    const ctx = canv.getContext("2d");
    window.canv = canv;
    window.ctx = ctx;
    window.Asteroid = Asteroid;
    window.Game = Game;
});