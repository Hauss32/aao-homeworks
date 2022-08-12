import { createSlice } from "@reduxjs/toolkit";

export const todosSlice = createSlice( {
    name: 'todos',
    initialState: {
        todos: []
    },
    reducers: {
        addTodo: (state, action) => {
            state.todos.push(action.payload);

            return state;
        }
    }
} )

export const { addTodo } = todosSlice.actions;

export default todosSlice.reducer;