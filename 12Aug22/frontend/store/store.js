import { configureStore } from "@reduxjs/toolkit";
import todosReducer from "../reducers/todos_slice";

export default configureStore( {
    reducer: {
        todos: todosReducer
    }
} )