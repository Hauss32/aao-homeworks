import React from "react";
import Tile from "./tile";

class Board extends React.Component {
    constructor(props) {
        super(props);

        this.updateGame = this.props.updateGame;
        this.board = this.props.board;

        this.handleClick = this.handleClick.bind(this);
    }

    render() {
        const tilesArr = this.board.grid.flat();

        return (
            <ul onClick={ this.handleClick }>
                { tilesArr.map( tile => <Tile tile={tile} key={tile.pos} /> ) }
            </ul>
        )
    }

    handleClick(event) {
        if ( event.target.tagName === 'LI' ) {
            const tilePos = event.target.getAttribute( 'pos' );
            const wasAltPressed = event.altKey;
            const tile = this.findTile( tilePos.split(',') );

            this.updateGame( tile, wasAltPressed );
        }
    }

    findTile(pos) {
        const matchedTile = this.board.grid.flat().find( tile => {
            return tile.pos[0] == pos[0] && tile.pos[1] == pos[1];
        } );

        return matchedTile;
    }
}

export default Board;