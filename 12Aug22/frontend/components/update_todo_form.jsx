import React from "react";
import { useSelector, useDispatch } from "react-redux";

export default function UpdateTodoForm() {
    let todos = useSelector( state => state.todos );
    todos = Object.values( todos ); //just need the ToDo objects as array

    const todoDropdownOptions = todos.map(todo => <option value={todo.id} key={todo.id}>{todo.title}</option> );
    const dispatch = useDispatch();

    return (
        <div className="update-todo-form-container">
            <form className="update-todo-form">
                <input type="hidden" name="id" id="todo-id"/>
                <label>
                    Select ToDo
                    <select name="todo" id="todo" defaultValue={""} onChange={ (event) => handleTodoSelection(event, todos) }>
                        <option value="" disabled>Choose a ToDo...</option>
                        { todoDropdownOptions }
                    </select>
                </label>
                <label>
                    Title
                    <input type="text" name="title" id="title" placeholder="Add title here..." required />
                </label>
                <label>
                    Body
                    <textarea name="body" id="body" placeholder="Add ToDo details here..." required></textarea>
                </label>
                <label>
                    Done?
                    <input type="checkbox" name="done" id="done" />
                </label>
                <input type="submit" value="Update ToDo" onClick={(event) => handleSubmit(event, dispatch)} />
            </form>
        </div>
    )
}

function handleSubmit(event, dispatch) {
    event.preventDefault();

    const form = event.currentTarget.parentElement;
    const formData = new FormData(form);
    const id = formData.get('id');
    const title = formData.get('title');
    const body = formData.get('body');
    const done = formData.get('done');

    if (title && body) {
        dispatch({ type: "todos/updateTodo", payload: { id, title, body, done } });
        form.reset();
    }
}

function handleTodoSelection(event, todos) {
    const form = event.currentTarget.parentElement.parentElement;
    const selectedID = event.currentTarget.value;
    const todoToUpdate = todos.find( todo => todo.id == selectedID );
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