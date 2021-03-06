const React = require( 'react' );
const { createRoot } = require( 'react-dom/client' );
const Autocomplete = require('./components/autocomplete');
const Clock = require( './components/clock' );
const Tabs = require( './components/tabs' );
const Weather = require( './components/weather' );

document.addEventListener( 'DOMContentLoaded', () => {
    const container = document.getElementById( 'root' );
    const root = createRoot( container );
    const tabData = [
        {
            title: 'Tabby Tab',
            content: 'Much content!'
        },
        {
            title: 'Tab Le',
            content: 'Such Wow!'
        },
        {
            title: 'Tab O\'Tabery',
            content: 'Many Content!'
        },
        {
            title: 'Tabbie McTabface',
            content: 'Last but not least!'
        }
    ];
    const names = [ 'Huey', 'Louie', 'Dewey', 'Alvin', 'Simon', 'Theodore', 
        'Brittany', 'Jeanette', 'Eleanor', 'Chuck', 'Clyde' ];
    
    root.render( <div><Clock /><Tabs tabs={tabData} /><Weather/><Autocomplete namesList={ names }/></div> );
})