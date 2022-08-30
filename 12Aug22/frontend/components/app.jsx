import React from "react";
import FormContainer from "./form_container";
import Todos from "./todos";

export default class App extends React.Component {
    constructor(props) {
        super(props);
    }

    render() {
        return (
            <div>
                <h1>ToDo App!</h1>
                <main>
                    <section className="form-container">
                        <FormContainer />
                    </section>
                    <section className="todos-container">
                        <Todos />
                    </section>
                </main>
            </div>
        )
    }
}