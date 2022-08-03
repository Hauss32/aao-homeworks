import React from 'react';
import * as Minesweeper from '../minesweeper';
import Board from './board';

class Game extends React.Component {
    constructor(props) {
        super(props)

        this.state = {
            board: new Minesweeper.Board(10, 10)
        }

        this.updateGame = this.updateGame.bind(this);
    }

    updateGame( tile, flagged ) {
        if ( flagged ) {
            tile.toggleFlag();
        } else {
            console.log(`${tile.pos} Explored!`);
            tile.explore();
            console.log(tile);
        }

        this.setState( { board: this.state.board } );
    }

    render() {
        return (
            <Board board={ this.state.board } updateGame={ this.updateGame }/>
        )
    }
}

export default Game;