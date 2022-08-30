import { createSlice } from "@reduxjs/toolkit";

export const todosSlice = createSlice( {
    name: 'todos',
    initialState: {
        currFormName: 'New',
        currTodo: undefined,
        allTodos: []
    },
    reducers: {
        setCurrTodo: (state, action) => {
            const todoID = parseInt(action.payload);
            const todo = state.allTodos[todoID];
    
            state.currTodo = todo;
    
            return state;
        },

        setCurrFormName: (state, action) => {
            const formName = action.payload;

            state.currFormName = formName;

            return state;
        },

        receiveTodos: (state, action) => {
            const todosArr = action.payload;

            todosArr.forEach( todo => state[todo.id] = todo );

            return state;
        },

        addTodo: (state, action) => {
            const todo = action.payload;
            const allIDs = Object.keys(state.allTodos);
            const maxID = (allIDs.length == 0) ? 0 : Math.max(...allIDs);
            const todoID = maxID + 1;

            todo.id = todoID;
            todo.steps = [];

            state.allTodos[todoID] = todo;

            return state;
        },

        removeTodo: (state, action) => {
            const todoID = action.payload;

            delete state.allTodos[todoID];

            return state;
        },

        updateTodo: (state, action) => {
            const newTodo = action.payload;
            const todoID = newTodo.id;
            const currTodo = state.allTodos[todoID];
            const keysToUpdate = Object.keys(newTodo);

            keysToUpdate.forEach( key => currTodo[key] = newTodo[key] );

            return state;
        },

        addStep: (state, action) => {
            const todoID = action.payload.id;
            const newStep = action.payload.step;
            const todo = state.allTodos[todoID];

            todo.steps.push( { done: false, description: newStep } );
            state.currTodo = todo;

            return state;
        },

        removeStep: (state, action) => {
            const todoID = action.payload.id;
            const stepText = action.payload.step;
            const todo = state.allTodos[todoID];
            const steps = todo.steps;
            const stepIdx = steps.findIndex( step => step.description == stepText );

            if (stepIdx > -1) {
                steps.splice(stepIdx, 1);
                state.currTodo = todo;
            }

            return state;
        }
    }
} )

export const { addTodo, removeTodo, updateTodo, setCurrTodo, receiveTodos } = todosSlice.actions;

export default todosSlice.reducer;