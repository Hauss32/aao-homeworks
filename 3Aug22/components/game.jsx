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
        this.resetGame = this.resetGame.bind(this);
    }

    updateGame( tile, flagged ) {
        if ( flagged ) {
            tile.toggleFlag();
        } else {
            tile.explore();
        }

        this.setState( { board: this.state.board }, () => {

        } );
    }

    resetGame(event) {
        event.preventDefault();

        const newBoard = new Minesweeper.Board(10, 10);

        this.setState( { board: newBoard } );
    }

    gameOverHelper() {
        const isWon = this.state.board.won();
        const isLost = this.state.board.lost();
        let modalTextFirst = '';
        let modalTextSecond = '';

        if ( !isWon && !isLost ) {
            return null;
        } else if ( isWon ) {
            modalTextFirst = "💯 YOU'VE WON!! 💯";
            modalTextSecond = "Way to not blow yourself up.";
        } else {
            modalTextFirst = "Bad news...";
            modalTextSecond = "💣💥🤕";
        }

        return (
            <div className='modal-container'>
                <div className='modal'>
                    <h1>
                        <span>{ modalTextFirst }</span>
                        <span>{ modalTextSecond}</span>
                    </h1>
                    <button className='game-reset' onClick={ this.resetGame }>New Game</button>
                </div>
            </div>
        )
    }

    render() {
        const modal = this.gameOverHelper();

        return (
            <div className="board">
                <Board board={ this.state.board } updateGame={ this.updateGame } />
                { modal }
            </div>
        )
    }
}

export default Game;