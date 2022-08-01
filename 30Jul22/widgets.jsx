const React = require( 'react' );
const { createRoot } = require( 'react-dom/client' );
const Clock = require( './components/clock' );

document.addEventListener( 'DOMContentLoaded', () => {
    const container = document.getElementById( 'root' );
    const root = createRoot( container );
    
    root.render( <Clock/> );
})