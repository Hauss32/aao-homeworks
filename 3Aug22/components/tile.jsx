import React from "react";

class Tile extends React.Component {
    constructor(props) {
        super(props);

        this.board = this.props.board;
        this.tile = this.props.tile;
        this.icon = this.findIcon();
        this.class = ( this.tile.explored ) ? 'explored' : 'secret';
    }

    render() {

        return (
            <li className={ this.class }>
                <div>{ this.icon }</div>
            </li>
        )
    }

    findIcon() {
        const bombed = this.tile.bombed;
        const flagged = this.tile.flagged;

        if ( !bombed && !flagged ) {
            return '';
        } else if ( bombed ) {
            return '💣';
        } else {
            return '🚩';
        }
    }
}

export default Tile;