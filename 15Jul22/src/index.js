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

$l.ajax = (options) => {
    const defaults = {
        contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
        dataType: 'json',
        method: 'GET',
        async: true
    }

    const promise = new Promise( (resolve, reject) => {
        const reqOptions = $l.extend(defaults, options);
        const req = new XMLHttpRequest();

        req.onload = function () {
            if (req.status === 200) {
                resolve(JSON.parse(req.response));
            } else {
                reject( Error(req.status) );
            }
        }
        req.open(reqOptions.method, reqOptions.url, reqOptions.async);
        req.send(reqOptions.data);
    });

    return promise;
}

window.addEventListener('DOMContentLoaded', (event) => {
    for( let i = 0; i < window.functionQueue.length; i++ ) {
        functionQueue[i]();
    }
});