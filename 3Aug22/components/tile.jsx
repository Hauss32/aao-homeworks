import React from "react";

class Tile extends React.Component {
    constructor(props) {
        super(props);
    }

    render() {
        const icon = this.findIcon();
        const cssClass = this.findClass();

        return (
            <li className={ cssClass } pos={ this.props.tile.pos }>
                <div>{ icon }</div>
            </li>
        )
    }

    findIcon() {
        const tile = this.props.tile;
        const bombed = tile.bombed;
        const flagged = tile.flagged;
        const explored = tile.explored;

        if ( !bombed && !flagged && !explored ) {
            return '';
        } else if ( flagged ) {
            return '🚩';
        } else if ( bombed ) {
            return '💣';
        } else {
            const numBombs = tile.adjacentBombCount();
            return ( numBombs === 0 ) ? '' : numBombs;
        }
    }

    findClass() {
        const tile = this.props.tile;

        if ( tile.flagged ) {
            return 'flagged';
        } else if ( tile.explored ) {
            return 'explored';
        } else {
            return 'secret';
        }
    }
}

export default Tile;