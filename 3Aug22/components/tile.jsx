import React from "react";

class Tile extends React.Component {
    constructor(props) {
        super(props);

        this.state = {
            board: this.props.board,
            pos: this.props.pos
        }
    }

    render() {
        return (
            <div>{ this.state.pos }</div>
        )
    }
}

export default Tile;