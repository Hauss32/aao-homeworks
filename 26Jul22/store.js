class Store {
    constructor(rootReducer, middlewares) {
        this.rootReducer = rootReducer;
        this.appliedMiddleware = applyMiddleware( ...middlewares );
        this.state = rootReducer( {}, { type: 'initializeState' } );
        this.subscriptions = [];

        this.getState = this.getState.bind(this);
        this.dispatch = this.dispatch.bind(this);
        this.subscribe = this.subscribe.bind(this);
    }

    getState() {
        return structuredClone(this.state);
    }

    dispatch(action) {
        const newState = this.appliedMiddleware(this, this.rootReducer)(action);
        this.state = newState;
        return newState;
    }

    subscribe(callback) {
        this.subscriptions.push( callback );
    }
}

function combineReducers(reducerMapping) {
    return (prevState, action, subscriptions=[]) => {
        const newState = {};
        let triggerSubscriptions = false;

        Object.keys(reducerMapping).forEach( key => {
            const prevVal = prevState[key];
            const reducer = reducerMapping[key];
            const result = reducer(prevVal, action);

            if ( prevVal !== result ) {
                triggerSubscriptions = true;
            }

            newState[key] = result;
        } )

        if ( triggerSubscriptions ) {
            subscriptions.forEach( callback => callback(newState) );
        }

        return newState;
    }
}

const applyMiddleware = (...middlewares) => (store, rootReducer) => action => {
    const middlewaresClone = [...middlewares];
    const invokeNextMiddleware = (action) => {
        let nextMiddleware = middlewaresClone.shift();

        if ( nextMiddleware ) {
            // we'll make some assumptions about the format of our middleware functions:
            // The format of a middleware function:
            // const aMiddleware = store => next => action => {...}
            return nextMiddleware(store)(invokeNextMiddleware)(action);
        } else {
            return rootReducer(store.state, action, store.subscriptions);
        }
    }

    return invokeNextMiddleware( action );
}

//this middleare needs to fire last
const reduxLogger = store => next => action => {
    console.log('\n----------------------');
    console.log('Previous State:');
    console.log(store.state);

    console.log('\nAction: '); 
    console.log(action); 

    //when this middle fires last, "next(action)" is rootReducer
    let nextState = next(action);

    console.log('\nNext State: ');
    console.log(nextState);
    console.log('----------------------\n');
}