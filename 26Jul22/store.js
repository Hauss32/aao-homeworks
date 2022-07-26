class Store {
    constructor(rootReudcer) {
        this.rootReudcer = rootReudcer;
        this.state = {};
    }

    getState() {
        return structuredClone(this.state);
    }

    dispatch(actions) {

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

