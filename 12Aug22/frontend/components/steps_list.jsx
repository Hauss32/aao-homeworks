import React from "react";
import { useSelector, useDispatch } from "react-redux";

export default function StepsList(props)  {
    const dispatch = useDispatch();
    const todo = props.todo;
    const steps = (todo) ? todo.steps : [];
    const stepEles = steps.map( (step, idx) => {
        const stepStatus = (step.done) ? 'complete' : 'incomplete';

        return (<li key={idx} className={stepStatus}>{step.description}</li>);
    })

    return (
        <ol onClick={ (event) => handleStepClick(event, todo, dispatch) }>
            { stepEles }
        </ol>
    )
}

function handleStepClick(event, todo, dispatch) {
    if ( !todo ) {
        return;
    }

    const clickedEle = event.target;

    if ( clickedEle.tagName == 'LI' ) {
        const stepText = clickedEle.textContent;
        const currSteps = [...todo.steps];
        const stepIdx = currSteps.indexOf(stepText);

        if ( stepIdx > -1 ) {
            currSteps.splice(index, 1);
        }

        dispatch({ type: "todos/updateTodo", payload: { id: todo.id, steps: currSteps } });
    }
}