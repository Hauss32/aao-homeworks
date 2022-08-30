import React from "react";
import { useSelector, useDispatch } from "react-redux";
import StepsList from "./steps_list";

export default function Todo(props) {
    const todo = props.todo;
    const isDone = todo.done;
    const doneText = (isDone) ? 'Done' : 'Incomplete';
    let classVal = 'todo-card';
    
    if (isDone) {
        classVal = classVal + ' complete';
    }

    return (
        <article key={todo.id} className={classVal}>
            <h1>{todo.title}</h1>
            <p>{todo.body}</p>
            <StepsList todo={todo}/>
            <p><b>Status: </b>{doneText}</p>
        </article>
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