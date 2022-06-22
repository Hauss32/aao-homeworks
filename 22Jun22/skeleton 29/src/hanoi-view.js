const Game = require('./game');

class View {
    constructor(game, $el) {
        this.game = game;
        this.$el = $el;
    }
}

module.exports = View;