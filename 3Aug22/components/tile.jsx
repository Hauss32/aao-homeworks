import React from "react";

class Tile extends React.Component {
    constructor(props) {
        super(props);

        this.board = this.props.board;
        this.tile = this.props.tile;
    }

    render() {
        const icon = this.findIcon();
        const cssClass = (this.tile.explored) ? 'explored' : 'secret';

        return (
            <li className={ cssClass } pos={ this.tile.pos }>
                <div>{ icon }</div>
            </li>
        )
    }

    findIcon() {
        const bombed = this.tile.bombed;
        const flagged = this.tile.flagged;
        const explored = this.tile.explored;

        if ( !bombed && !flagged && !explored ) {
            return '';
        } else if ( bombed ) {
            return '💣';
        } else if ( flagged ) {
            return '🚩';
        } else {
            const numBombs = this.tile.adjacentBombCount();
            return ( numBombs === 0 ) ? '' : numBombs;
        }
    }
}

export default Tile;