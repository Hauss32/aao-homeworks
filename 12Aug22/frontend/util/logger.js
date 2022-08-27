const logger = store => next => action => {
    console.log('Previous State: ', store.getState() );

    next(action);

    console.log('New State: ', store.getState());
}

export default logger;