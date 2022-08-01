const React = require( 'react' );
const { createRoot } = require( 'react-dom/client' );

document.addEventListener( 'DOMContentLoaded', () => {
    const container = document.getElementById( 'root' );
    const root = createRoot( container );
    
    root.render( <div></div> );
})