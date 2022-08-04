import React from "react";
import Tile from "./tile";

class Board extends React.Component {
    constructor(props) {
        super(props);

        this.handleClick = this.handleClick.bind(this);
    }

    handleClick(event) {
        //allow flagged icon to still allow click event from LI
        if( event.target.tagName === 'DIV' ) {
            event.target = event.target.parentElement;
        }

        if ( event.target.tagName === 'LI' ) {
            const tilePos = event.target.getAttribute( 'pos' );
            const wasAltPressed = event.altKey;
            const tile = this.findTile( tilePos.split(',') );
            
            if ( tile.flagged && !wasAltPressed ) { return; } //"lock" flagged cells from being revealed

            this.props.updateGame( tile, wasAltPressed );
        }
    }

    findTile(pos) {
        const matchedTile = this.props.board.grid.flat().find( tile => {
            return tile.pos[0] == pos[0] && tile.pos[1] == pos[1];
        } );

        return matchedTile;
    }

    render() {
        const tilesArr = this.props.board.grid.flat();

        return (
            <ul onClick={this.handleClick}>
                { tilesArr.map(tile => <Tile tile={tile} key={tile.pos} />) }
            </ul>
        )
    }
}

export default Board;