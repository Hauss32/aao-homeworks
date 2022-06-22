class View {
  constructor(game, $el) {
    this.$el = $el;
    this.game = game;
    this.setupBoard($el);
    this.bindEvents();
  }
}

View.prototype.setupBoard = function() {
  const $gridList = $('<ul></ul>');
  const numCells = 9;

  $gridList.addClass('grid');
  this.$el.append($gridList);
  
  for (let i = 0; i < numCells; i++) {
    const xPos = i % 3;
    const yPos = Math.floor(i / 3);
    const $cell = $('<li></li>');
    $cell.addClass('unclicked');
    $cell.data('pos', [xPos, yPos]);
    $gridList.append($cell);
  }
}

View.prototype.swapPlayer = function () {
  (window.currentPlayer === 'X') ? window.currentPlayer = 'O' : window.currentPlayer = 'X';
}

View.prototype.makeMove = function ($cell) {
  const moveClass = ( window.currentPlayer === 'X' ) ? 'x-cell' : 'o-cell';
  $cell.removeClass('unclicked');
  $cell.addClass(moveClass);
  $cell.html(window.currentPlayer);
  const cellPos = $cell.data('pos');
  this.game.playMove(cellPos);

  if ( this.game.isOver() ) {
    window.setTimeout( () => {
      alert(`Well played! The winner is ${this.game.winner() || 'NOBODY 👎'}.`);
      this.$el.off('click', 'li.unclicked');
      this.$el.find('li.unclicked').removeClass('unclicked');
    }, 100);
  } else {
    this.swapPlayer();
  }
}

View.prototype.bindEvents = function () {
  const view = this;
  view.$el.on('click', 'li.unclicked', function () {
    const $cell = $(this);
    view.makeMove($cell);
  })
}

module.exports = View;
