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

const myNoiseReducer = (prevState = "peace and quiet", action) => {
    switch (action.type) {
        case "noisy action":
            return action.noise;
        default:
            return prevState;
    }
};

const myNoisyAction = {
    type: "noisy action",
    noise: "Car alarm"
};

const myInconsequentialAction = {
    type: "a type no one cares about",
    data: {
        thisThing: "will not get used anyway"
    }
};

const myInitialState = {
    noise: "peace and quiet"
};

const myRootReducer = combineReducers({
    noise: myNoiseReducer,
});

let newState = myRootReducer(myInitialState, myInconsequentialAction);
// => { noise: "peace and quiet" }
console.log(newState);

newState = myRootReducer(newState, myNoisyAction)
// => { noise: "Car alarm" }
console.log(newState);

myRootReducer(newState, myInconsequentialAction)
// => { noise: "Car alarm" }
console.log(newState);