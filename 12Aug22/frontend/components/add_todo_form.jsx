import React from "react";
import { useDispatch } from "react-redux";
import { addTodo } from "../reducers/todos_slice";

export default function AddTodoForm() {
    const dispatch = useDispatch();

    return (
        <div className="add-todo-form-container">
            <form className="add-todo-form">
                <label>
                    Title
                    <input type="text" name="title" id="title" placeholder="Add title here..."/>
                </label>
                <label>
                    Body
                    <textarea name="body" id="body" placeholder="Add ToDo details here..."></textarea>
                </label>
                <input type="submit" value="Add ToDo" onClick={ (event) => handleClick(event, dispatch) }/>
            </form>
        </div>
    )
}

function handleClick(event, dispatch) {
    event.preventDefault();

    const form = event.currentTarget.parentElement;
    console.log(form);
    const formData = new FormData(form);
    const title = formData.get('title');
    const body = formData.get('body');
    const done = false;

    dispatch( { type: "todos/addTodo", payload: { title, body, done } } );
}