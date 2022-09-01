import React from "react";
import { useSelector, useDispatch } from "react-redux";
import AddTodoForm from "./add_todo_form";
import AddStepForm from "./add_todo_step";
import RemoveTodoForm from "./remove_todo_form";
import UpdateTodoForm from "./update_todo_form";

export default function FormContainer() {
    const FORM_TABS = {
        'New': <AddTodoForm />,
        'Update': <UpdateTodoForm />,
        'Delete': <RemoveTodoForm />,
        'AddStep': <AddStepForm />
    }
    const dispatch = useDispatch();
    const currFormName = useSelector(state => state.todos.currFormName);
    const formComponent = (currFormName) ? FORM_TABS[currFormName] : <AddTodoForm />

    let formNames = Object.keys(FORM_TABS);
    formNames = formNames.filter( name => name !== 'AddStep' ); //AddStep should not be visible tab option

    return (
        <div className="forms-container">
            <nav className="form-selector">
                <ul className="form-tabs" onClick={event => handleClick(event, dispatch)}>
                    {
                        formNames.map(name => {
                            const classVal = (name == currFormName) ? 'tab-selected' : '';

                            return (
                                <li key={name} form_name={name} className={classVal}>{name}</li>
                            );
                        })
                    }
                </ul>
            </nav>
            <div id="form-content">
                { formComponent }
            </div>
        </div>
    )
}

function handleClick(event, dispatch) {
    const clickedTagName = event.target.tagName;

    if(clickedTagName !== 'LI') {
        return;
    } else {
        const formName = event.target.getAttribute('form_name');
        console.log(formName);
        dispatch({ type: "todos/setCurrFormName", payload: formName });
    }
}