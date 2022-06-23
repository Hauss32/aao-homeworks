//require some stuff
const Snake = require('./snake');
const Board = require('./board');
const SnakeView = require('./snake_view')

$( () => {
    const $el = $( '.snake' );
    const snake = new Snake();
    const board = new Board(snake); 
    const view = new SnakeView(board, $el);
})