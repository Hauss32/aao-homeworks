import { createRoot } from 'react-dom/client';
import React from 'react';
import Game from './components/game';

document.addEventListener( 'DOMContentLoaded', () => {
    const container = document.getElementById( 'root' );
    const root = createRoot( container );

    root.render(<Game/>);
})