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
        const tilesArr = this.state.board.grid.flat();
        
        return (
            <ul>
                { tilesArr.map( tile => <Tile tile={tile} key={tile.pos} /> ) }
            </ul>
        )
    }
}

export default Board;