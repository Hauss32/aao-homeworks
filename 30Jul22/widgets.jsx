const React = require( 'react' );
const { createRoot } = require( 'react-dom/client' );
const Clock = require( './components/clock' );
const Tabs = require( './components/tabs' );

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
    
    root.render( <div><Clock /><Tabs tabs={tabData} /></div> );
})