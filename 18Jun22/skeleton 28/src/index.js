const View = require('./ttt-view');
const Game = require('../js/game');

  $(() => {
    const game = new Game();
    const $grid = $('.ttt').first();
    const view = new View(game, $grid);
    window.currentPlayer = 'X';
  });
