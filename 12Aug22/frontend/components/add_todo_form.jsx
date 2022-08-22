import React from "react";
import { useDispatch } from "react-redux";

export default function AddTodoForm() {
    const dispatch = useDispatch();

    return (
        <div className="add-todo-form-container">
            <form className="add-todo-form">
                <label>
                    Title
                    <input type="text" name="title" id="title" placeholder="Add title here..." required/>
                </label>
                <label>
                    Body
                    <textarea name="body" id="body" placeholder="Add ToDo details here..." required></textarea>
                </label>
                <input type="submit" value="Add ToDo" onClick={ (event) => handleClick(event, dispatch) }/>
            </form>
        </div>
    )
}

function handleClick(event, dispatch) {
    event.preventDefault();

    const form = event.currentTarget.parentElement;
    const formData = new FormData(form);
    const title = formData.get('title');
    const body = formData.get('body');
    const done = false;

    if (title && body) {
        dispatch( { type: "todos/addTodo", payload: { title, body, done } } );
        form.reset();
    }
}