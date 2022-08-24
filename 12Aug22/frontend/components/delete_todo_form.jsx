import React from "react";
import { useSelector, useDispatch } from "react-redux";

export default function RemoveTodoForm() {
    let todos = useSelector(state => state.todos);
    todos = Object.values(todos); //just need the ToDo objects as array

    const todoDropdownOptions = todos.map(todo => <option value={todo.id} key={todo.id}>{todo.title}</option>);
    const dispatch = useDispatch();

    return (
        //TODO Decompose this form so UpdateTodoForm can share components
        <div className="remove-todo-form-container">
            <form className="remove-todo-form">
                <input type="hidden" name="id" id="todo-id" />
                <label>
                    Select ToDo
                    <select name="todo" id="todo" defaultValue={""} onChange={(event) => handleTodoSelection(event, todos)}>
                        <option value="" disabled>Choose a ToDo...</option>
                        {todoDropdownOptions}
                    </select>
                </label>
                <label>
                    Title
                    <input type="text" name="title" id="title" disabled />
                </label>
                <label>
                    Body
                    <textarea name="body" id="body" disabled></textarea>
                </label>
                <label>
                    Done?
                    <input type="checkbox" name="done" id="done" disabled/>
                </label>
                <input type="submit" value="Delete ToDo" onClick={(event) => handleSubmit(event, dispatch)} />
            </form>
        </div>
    )
}

function handleSubmit(event, dispatch) {
    event.preventDefault();

    const form = event.currentTarget.parentElement;
    const formData = new FormData(form);
    const id = formData.get('id');

    if (id) {
        dispatch({ type: "todos/removeTodo", payload: id });
        form.reset();
    }
}

function handleTodoSelection(event, todos) {
    const form = event.currentTarget.parentElement.parentElement;
    const selectedID = event.currentTarget.value;
    const todoToUpdate = todos.find(todo => todo.id == selectedID);
    const idEle = form.querySelector('#todo-id');
    const titleEle = form.querySelector('#title');
    const bodyEle = form.querySelector('#body');
    const doneEle = form.querySelector('#done');

    //fill in the form based on dropdown selection
    idEle.value = selectedID;
    titleEle.value = todoToUpdate.title;
    bodyEle.value = todoToUpdate.body;
    doneEle.checked = todoToUpdate.done;
}