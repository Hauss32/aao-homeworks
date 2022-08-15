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
        }
    }
} )

export const { addTodo } = todosSlice.actions;

export default todosSlice.reducer;