import { configureStore } from "@reduxjs/toolkit";
import todosReducer from "../reducers/todos_slice";
import logger from "../util/logger";

export default configureStore( {
    reducer: {
        todos: todosReducer
    },

    middleware: [ logger ]
} )