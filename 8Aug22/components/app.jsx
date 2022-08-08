import React from "react";
import { Postings } from "./postings";

class App extends React.Component {
    constructor(props) {
        super(props);
    }

    render() {
        return (
            <div>
                <Postings/>
            </div>
        )
    }
}

export default App;