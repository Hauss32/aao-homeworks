import React from "react";
import AddTodoForm from "./add_todo_form";
import AddStepForm from "./add_todo_step";
import RemoveTodoForm from "./remove_todo_form";
import FormContainer from "./form_container";
import UpdateTodoForm from "./update_todo_form";

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
                        <FormContainer/>
                    </section>
                    <section>
                        <ul>
                            <li>
                                <h1>Todo #1</h1>
                            </li>
                            <li>
                                <h1>Todo #2</h1>
                            </li>
                            <li>
                                <h1>Todo #3</h1>
                            </li>
                        </ul>
                    </section>
                </main>
            </div>
        )
    }
}