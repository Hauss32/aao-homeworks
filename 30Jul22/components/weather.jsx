const React = require('react');

class Weather extends React.Component {
    constructor(props) {
        super( props );

        this.state = {
            status: null,
            latitude: null,
            longitude: null
        }
    }

    render() {
        const weatherText = this.weatherStatusHelper();

        return (
            <div className='widget weather'>
                <h1>{ weatherText }</h1>
            </div>
        )
    }

    componentDidMount() {
        const weatherPromise = new Promise( (resolve, reject) => {
            navigator.geolocation.getCurrentPosition(
                position => resolve(position),
                error => reject(error)
            );
        });

        weatherPromise.then( position => {
            this.getWeather(position);

        } ).catch( error => {
            console.error( error );

            this.setState( { status: 'error' } );
        } );
    }

    weatherStatusHelper() {
        switch (this.state.status) {
            case null:
                return "Searching for current weather...";
            case 'found':
                return "Current Weather:";
            default:
                return "Unable to get current weather"
        }
    }

    getWeather(position) {
        const latitude = position.coords.latitude;
        const longitude = position.coords.longitude;
        const apiKey = '40a8d266457e2303ada1c217dda0ffd5';
        const url = `https://api.openweathermap.org/data/2.5/weather?lat=${latitude}&lon=${longitude}&appid=${apiKey}`

        const req = new XMLHttpRequest();

        req.open("GET", url, true);

        req.onload = () => {
            if (req.status == 200) {
                console.log(req.response);
            } else {
                console.log('Request Failed');
                console.log(req.response);
            }
        }

        req.send();
    };

    makeIconURL(iconCode) {
        return `http://openweathermap.org/img/wn/${iconCode}@2x.png`
    }

    parseAndSetWeatherData(data) {
        
    }
}

module.exports = Weather;