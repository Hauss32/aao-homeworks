import React from 'react';
import { createRoot } from 'react-dom/client';
import { Provider } from 'react-redux';
import store from './frontend/store/store';
import App from './frontend/components/app';

document.addEventListener('DOMContentLoaded', () => {
    const container = document.getElementById( 'root' );
    const root = createRoot( container );
    window.store = store;

    root.render( 
        <Provider store={ store }>
            <App/>
        </Provider>
    )
})