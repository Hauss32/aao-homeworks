//require some stuff
const Snake = require('./snake');
const Board = require('./board');

$( () => {
    const $el = $( '.snake' );
    const snake = new Snake();
    const board = new Board(snake, $el);
})