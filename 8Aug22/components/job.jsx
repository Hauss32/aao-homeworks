import React from "react";

class Job extends React.Component {
    constructor(props) {
        super(props);
    }

    render() {
        const { 
            title, 
            company, 
            type, 
            location, 
            description, 
            url 
        } = this.props.job;

        return (
            <ul>
                <li><b>Title: </b>{ title }</li>
                <li><b>Company: </b>{ company }</li>
                <li><b>Type: </b>{ type }</li>
                <li><b>Location: </b>{ location }</li>
                <li><b>Description: </b>{ description }</li>
                <li><b>URL: </b>{ url }</li>
            </ul>
        )
    }
}

export default Job;