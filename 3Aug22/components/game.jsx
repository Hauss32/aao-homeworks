import React from 'react';
import * as Minesweeper from 'minesweeper';

class Game extends React.Component {
    constructor(props) {
        super(props)

        this.state = {
            board: new Minesweeper.Board(10, 10)
        }

        this.updateGame = this.updateGame.bind(this);
    }

    updateGame() {

    }

    render() {
        return (
            <Board board={ this.state.board } update={ this.updateGame }/>
        )
    }
}

export default Game;