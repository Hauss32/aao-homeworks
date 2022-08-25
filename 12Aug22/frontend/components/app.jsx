import React from "react";
import AddTodoForm from "./add_todo_form";
import AddStepForm from "./add_todo_step";
import RemoveTodoForm from "./delete_todo_form";
import UpdateTodoForm from "./update_todo_form";

export default class App extends React.Component {
    constructor(props) {
        super(props);
    }

    render() {
        return (
            <div>
                <h1>Hello, TODOs!</h1>
                <AddTodoForm/>
                <UpdateTodoForm/>
                <RemoveTodoForm/>
                <AddStepForm/>
            </div>
        )
    }
}