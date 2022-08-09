import { createSlice } from "@reduxjs/toolkit";

export const postingsSlice = createSlice( {
    name: 'postings',
    initialState: {
        location: 'Please Select',
        jobs: []
    },
    reducers: {
        findJobs: (state, action) => {
            state.location = action.location;
            state.jobs = action.jobs;

            return state;
        }
    }
} )

export const { findJobs } = postingsSlice.actions;

export default postingsSlice.reducer;