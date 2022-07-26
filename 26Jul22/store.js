class Store {
    constructor(rootReducer) {
        this.rootReducer = rootReducer;
        this.state = rootReducer( {}, { type: 'initializeState' } );
        this.subscriptions = [];
    }

    getState() {
        return structuredClone(this.state);
    }

    dispatch(action) {
        this.state = this.rootReducer( this.state, action, this.subscriptions );
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