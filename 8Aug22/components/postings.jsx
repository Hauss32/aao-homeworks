import React from "react";
import { useSelector, useDispatch } from "react-redux";
import Job from "./job";
import { findJobs } from "../features/postings/postingsSlice";

export function Postings() {
    const state = useSelector( state => state );
    const postings = state.postings;
    const dispatch = useDispatch();
    const { location, jobs, filteredJobs } = postings;
    const jobsCount = filteredJobs.length;
    let allLocations = jobs.map( job => job.location );

    allLocations = [...new Set(allLocations)].sort(); //get sorted unique locations

    return (
        <div>
            <h1>Location: { location }</h1>
            {          
                allLocations.map( location => {
                    return (
                        <button 
                            key={ location } 
                            aria-label={ `Filter jobs to ${location}` }
                            onClick={ (event) => {
                                event.preventDefault();
                                return dispatch( { type: "postings/findJobs", payload: event.currentTarget.textContent } );
                        } }>
                            { location }
                        </button>
                    )} )
            }
            <h2>Jobs Count: { jobsCount }</h2>
            <ul>
                {
                    filteredJobs.map( job => <Job job={job} key={job.id}></Job>)
                }
            </ul>
        </div>
    )
}