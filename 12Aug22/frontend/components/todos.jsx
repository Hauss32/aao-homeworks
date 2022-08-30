import React from "react";
import { useSelector, useDispatch } from "react-redux";
import Todo from "./todo";

export default function Todos() {
    const dispatch = useDispatch();
    const todosState = useSelector(state => state.todos.allTodos);
    const todos = Object.values(todosState);

    return (
        <div className="todos-container">
            {
                todos.map( todo => <Todo key={todo.id} todo={todo} /> )
            }
        </div>
    )
}

function handleClick(event, dispatch) {
    const clickedTagName = event.target.tagName;

    if (clickedTagName !== 'LI') {
        return;
    } else {
        const formName = event.target.getAttribute('form_name');
        console.log(formName);
        dispatch({ type: "todos/setCurrFormName", payload: formName });
    }
}