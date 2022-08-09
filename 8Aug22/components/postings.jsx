import React from "react";
import { useSelector, useDispatch } from "react-redux";
import Job from "./job";
import getJobs from "../features/postings/jobs_callout";

export function Postings() {
    const state = useSelector( state => state );
    const postings = state.postings;
    const dispatch = useDispatch();
    const { location, jobs } = postings;
    const jobsCount = jobs.length;
    let allLocations = ["New York", "San Francisco", "Los Angeles"];

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

                                const city = event.currentTarget.textContent;
                                const jobsPromise = getJobs(city);

                                jobsPromise.then( data => {
                                    const jobs = JSON.parse(data);
                                    const location = city;

                                    dispatch({ type: "postings/findJobs", location, jobs });
                                })
                                
                        } }>
                            { location }
                        </button>
                    )} )
            }
            <h2>Jobs Count: { jobsCount }</h2>
            <ul>
                {
                    jobs.map( job => <Job job={job} key={job.id}></Job>)
                }
            </ul>
        </div>
    )
}