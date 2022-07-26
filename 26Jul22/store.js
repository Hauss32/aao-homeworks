class Store {
    constructor(rootReudcer) {
        this.rootReudcer = rootReudcer;
        this.state = {};
    }

    getState() {
        return structuredClone(this.state);
    }
}

function combineReducers(reducerMapping) {
    return (prevState, action) => {
        const newState = {};

        Object.keys(prevState).forEach(key => {
            const prevVal = prevState[key];
            const reducer = reducerMapping[key];
            const result = reducer(prevVal, action);
            newState[key] = result;
        })
        return newState;
    }
}