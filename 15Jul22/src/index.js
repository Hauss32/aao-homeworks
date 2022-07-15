const DomNodeCollection = require('./dom_node_collection'); 

window.functionQueue = [];

window.$l = function(selector) {
    if ( selector instanceof HTMLElement) {
        return new DomNodeCollection( [selector] );
    } else if ( selector instanceof Function) {
        if (document.readyState === 'complete') {
            selector();
        } else {
            window.functionQueue.push(selector);
        }
    } else {
        const htmlArr = Array.from( document.querySelectorAll(selector) );
        return new DomNodeCollection( htmlArr );
    }
}

$l.extend = (...objs) => {
    const finalObj = objs[0];
    objs.forEach( obj => {
        for ( const key in obj) {
            finalObj[key] = obj[key];
        }
    })

    return finalObj;
}

window.addEventListener('DOMContentLoaded', (event) => {
    for( let i = 0; i < window.functionQueue.length; i++ ) {
        functionQueue[i]();
    }
});