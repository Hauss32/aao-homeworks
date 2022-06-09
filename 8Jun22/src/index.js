const MovingObject = require('./moving_object');
const Asteroid = require('./asteroid');
const Util = require('./utils');

window.MovingObject = MovingObject;

window.addEventListener('DOMContentLoaded', (event) => {
    const canv = document.getElementById('game-canvas');
    const ctx = canv.getContext("2d");
    window.ctx = ctx;
    window.clearCanv = Util.clearCanv
    window.Asteroid = Asteroid;
});