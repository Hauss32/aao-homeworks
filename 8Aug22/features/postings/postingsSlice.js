import { createSlice } from "@reduxjs/toolkit";

export const postingsSlice = createSlice( {
    name: 'postings',
    initialState: {
        location: 'Please Select',
        jobs: [
            {
                id: 1,
                title: "Test Job",
                company: "Github",
                type: "Full Time",
                location: "remote",
                description: "test description",
                url: "www.github.com/appacademy"
            }
        ],
        filteredJobs: []
    },
    reducers: {
        findJobs: (state, action) => {
            state.location = action.payload;
            state.filteredJobs = state.jobs.filter( job => job.location == state.location );
        }
    }
} )

export const { findJobs } = postingsSlice.actions;

export default postingsSlice.reducer;