import React from "react";
import Tile from "./tile";

class Board extends React.Component {
    constructor(props) {
        super(props);

        this.state = {
            board: this.props.board
        }
    }

    render() {
        const coordsArr = this.state.board.grid.flat().map( tile => tile.pos );
        
        return (
            <div>
                { coordsArr.map( coord => <Tile board={ this.state.board } pos={ coord } key={ coord } /> ) }
            </div>
        )
    }
}

export default Board;