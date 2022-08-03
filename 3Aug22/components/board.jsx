import React from "react";

class Board extends React.Component {
    constructor(props) {
        super(props);

        this.state = {
            board: this.props.board
        }
    }

    render() {
        return (
            <h1>Hello, World!</h1>
        )
    }
}

export default Board;