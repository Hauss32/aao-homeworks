const React = require('react');

class Weather extends React.Component {
    constructor(props) {
        super( props );

        this.state = {
            status: 'Finding weather data...',
            description: '',
            iconURL: '',
            temp: '',
            feelsLike: '',
            minTemp: '',
            maxTemp: '',
            location: ''
        }
    }

    render() {
        const weatherDetails = ( this.state.temp ) ? 
            this.createWeatherElements() : <h1>{ this.state.status }</h1>;

        return (
            <div className='widget weather'>
                { weatherDetails }
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
            this.getWeather( position );
        } ).catch( error => {
            console.error( error );

            this.setState({ status: 'Unable to get current weather.' } );
        } );
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
                const weatherJSON = JSON.parse( req.response );
                this.parseAndSetWeatherState( weatherJSON );
            } else {
                console.log('Request Failed');
                console.log(req.response);
            }
        }

        req.send();
    };

    makeIconURL(iconCode) {
        return `http://openweathermap.org/img/wn/${iconCode}@4x.png`
    }

    convertTempF(tempKelvin) {
        const tempInF = ((tempKelvin - 273.15) * 9 / 5 + 32);
        return tempInF.toFixed(1);
    }

    parseAndSetWeatherState(weatherJSON) {
        const description = weatherJSON.weather[0].description;
        const iconURL = this.makeIconURL( weatherJSON.weather[0].icon );
        const temp = this.convertTempF( weatherJSON.main.temp );
        const feelsLike = this.convertTempF( weatherJSON.main.feels_like );
        const minTemp = this.convertTempF( weatherJSON.main.temp_min );
        const maxTemp = this.convertTempF( weatherJSON.main.temp_max );
        const location = weatherJSON.name;

        this.setState( {
            description,
            iconURL,
            temp,
            feelsLike,
            minTemp,
            maxTemp,
            location
        } );
    }

    //TODO: this can be extracted to its own component
    createWeatherElements() {
        return (
            <div className='weather-details'>
                <ul>
                    <li>{ this.state.description }</li>
                    <li>Temperature: { this.state.temp }°F</li>
                    <li>Feels Like: {this.state.feelsLike}°F</li>
                    <li>Today's High: {this.state.maxTemp}°F</li>
                    <li>Today's Low: {this.state.minTemp}°F</li>
                </ul>
                <img src={ this.state.iconURL } alt={ this.state.iconURL + ' icon' } />
                <p>Detected Location: { this.state.location }</p>
            </div>
        )
    }
}

module.exports = Weather;