const DomNodeCollection = require('./dom_node_collection'); 

window.$l = function(selector) {
    if ( selector instanceof HTMLElement) {
        return new DomNodeCollection( [selector] );
    } else {
        const htmlArr = Array.from( document.querySelectorAll(selector) );
        return new DomNodeCollection( htmlArr );
    }
}

window.addEventListener('DOMContentLoaded', (event) => {
    // DOM ready code
});