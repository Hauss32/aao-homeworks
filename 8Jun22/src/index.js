const MovingObject = require('./moving_object');
const Util = require('./utils');

window.MovingObject = MovingObject;

window.addEventListener('DOMContentLoaded', (event) => {
    const canv = document.getElementById('game-canvas');
    const ctx = canv.getContext("2d");
    window.clearCanv = () => {
        ctx.clearRect(0, 0, canv.width, canv.height);
    };
    window.ctx = ctx;
});