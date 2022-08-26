import React from "react";
import { useSelector, useDispatch } from "react-redux";
import StepsList from "./steps_list";

export default function AddStepForm() {
    const todosState = useSelector(state => state.todos);
    const currTodo = todosState.currTodo;
    let todos = todosState.allTodos;
    todos = Object.values(todos); //just need the ToDo objects as array

    const todoDropdownOptions = todos.map(todo => <option value={todo.id} key={todo.id}>{todo.title}</option>);
    const dispatch = useDispatch();

    return (
        <div className="add-step-form-container">
            <form className="add-step-form">
                <input type="hidden" name="id" id="todo-id" />
                <label>
                    Select ToDo
                    <select name="todo" id="todo" defaultValue={""} onChange={(event) => handleTodoSelection(event, dispatch)}>
                        <option value="" disabled>Choose a ToDo...</option>
                        {todoDropdownOptions}
                    </select>
                </label>
                <StepsList todo={ currTodo } />
                <label>
                    Step Description (short)
                    <input type="text" name="step" id="step" />
                </label>
                <input type="submit" value="Add Step" onClick={(event) => handleSubmit(event, dispatch)} />
            </form>
        </div>
    )
}

function handleSubmit(event, dispatch) {
    event.preventDefault();

    const form = event.currentTarget.parentElement;
    const formData = new FormData(form);
    const id = formData.get('id');
    const step = formData.get('step');

    if (id && step) {
        dispatch({ type: "todos/addStep", payload: { id, step } });
        form.querySelector('#step').value = ''; //reset step input
    }
}

function handleTodoSelection(event, dispatch) {
    const form = event.currentTarget.parentElement.parentElement;
    const selectedID = event.currentTarget.value;
    const idEle = form.querySelector('#todo-id');

    dispatch({ type: "todos/setCurrTodo", payload: selectedID });

    //fill in the form based on dropdown selection
    idEle.value = selectedID;
}