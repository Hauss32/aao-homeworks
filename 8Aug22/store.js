import { configureStore } from '@reduxjs/toolkit';
import postingsReducer from './features/postings/postingsSlice';

export default configureStore( {
    reducer: {
        postings: postingsReducer
    }
} );