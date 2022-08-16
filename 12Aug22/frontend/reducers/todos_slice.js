import { createSlice } from "@reduxjs/toolkit";

export const todosSlice = createSlice( {
    name: 'todos',
    initialState: {},
    reducers: {
        receiveTodos: (state, action) => {
            const todosArr = action.payload;

            todosArr.forEach( todo => state[todo.id] = todo );

            return state;
        },

        addTodo: (state, action) => {
            const todo = action.payload;
            const allIDs = Object.keys(state);
            const maxID = (allIDs.length == 0) ? 0 : Math.max(...allIDs);
            const todoID = maxID + 1;

            state[todoID] = todo;

            return state;
        },

        removeTodo: (state, action) => {
            const todoID = action.payload;

            delete state[todoID];

            return state;
        },

        updateTodo: (state, action) => {
            const newTodo = action.payload;
            const todoID = newTodo.id;
            const currTodo = state[todoID];
            const keysToUpdate = Object.keys(newTodo);

            keysToUpdate.forEach( key => currTodo[key] = newTodo[key] );

            return state;
        }
    }
} )

export const { addTodo, removeTodo, updateTodo, receiveTodos } = todosSlice.actions;

export default todosSlice.reducer;