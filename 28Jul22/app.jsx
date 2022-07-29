const React = require('react');
const { createRoot } = require('react-dom/client');
const Calculator = require('./components/calculator');


document.addEventListener( 'DOMContentLoaded', () => {
    const container = document.getElementById( 'root' );
    const root = createRoot(container);
    root.render( <Calculator/>);
})