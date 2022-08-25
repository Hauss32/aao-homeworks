import React from "react";
import { useSelector, useDispatch } from "react-redux";

export default function AddStepForm() {
    let todos = useSelector(state => state.todos);
    todos = Object.values(todos); //just need the ToDo objects as array

    const todoDropdownOptions = todos.map(todo => <option value={todo.id} key={todo.id}>{todo.title}</option>);
    const dispatch = useDispatch();

    return (
        <div className="add-step-form-container">
            <form className="add-step-form">
                <input type="hidden" name="id" id="todo-id" />
                <label>
                    Select ToDo
                    <select name="todo" id="todo" defaultValue={""} onChange={(event) => handleTodoSelection(event, todos)}>
                        <option value="" disabled>Choose a ToDo...</option>
                        {todoDropdownOptions}
                    </select>
                </label>
                <ol className="steps-list"></ol>
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
    const stepsListEle = form.querySelector('.steps-list');

    if (id && step) {
        dispatch({ type: "todos/addStep", payload: { id, step } });
        form.reset();
        stepsListEle.innerHTML = '';
    }
}

function handleTodoSelection(event, todos) {
    const form = event.currentTarget.parentElement.parentElement;
    const selectedID = event.currentTarget.value;
    const todoToUpdate = todos.find(todo => todo.id == selectedID);
    const stepsArr = todoToUpdate.steps;
    const idEle = form.querySelector('#todo-id');
    const stepsListEle = form.querySelector('.steps-list');

    const existingStepEles = stepsArr.map( step => `<li>${step}</li>` );

    //fill in the form based on dropdown selection
    idEle.value = selectedID;
    existingStepEles.forEach(stepEle => stepsListEle.insertAdjacentHTML('beforeend', stepEle) );
}