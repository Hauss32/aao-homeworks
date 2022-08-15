import { createSlice } from "@reduxjs/toolkit";

export const todosSlice = createSlice( {
    name: 'todos',
    initialState: {},
    reducers: {
        addTodo: (state, action) => {
            const todo = action.payload;
            const todoID = todo.id;

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

export const { addTodo, removeTodo, updateTodo } = todosSlice.actions;

export default todosSlice.reducer;