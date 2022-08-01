const React = require( 'react' );

class Clock extends React.Component {
    constructor(props) {
        super( props );

        this.state = {
            time: new Date()
        }
    }

    render() {
        const date = this.state.time;
        const dateFormatted = date.toLocaleString('en-US', {
            timeZone: 'America/Los_Angeles',
        });

        return (
            <div className='widget clock'>
                <h1>Current Time:</h1>
                <p>{ dateFormatted }</p>
            </div>
        )
    }

    tick() {
        this.setState( { time: new Date() } );
    }

    componentDidMount() {
        this.interval = setInterval( () => {
            this.tick();
        }, 1000)
    }

    componentWillUnmount() {
        clearInterval( this.interval );
    }
}

module.exports = Clock;