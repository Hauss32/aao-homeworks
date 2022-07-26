class Store {
    constructor(rootReducer) {
        this.rootReducer = rootReducer;
        this.state = rootReducer( {}, { type: 'initializeState' } );
    }

    getState() {
        return structuredClone(this.state);
    }

    dispatch(action) {
        this.state = this.rootReducer( this.state, action );
    }
}

function combineReducers(reducerMapping) {
    return (prevState, action) => {
        const newState = {};

        Object.keys(reducerMapping).forEach( key => {
            const prevVal = prevState[key];
            const reducer = reducerMapping[key];
            const result = reducer(prevVal, action);
            newState[key] = result;
        } )
        return newState;
    }
}