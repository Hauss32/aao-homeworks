const Router = require("./router");

document.addEventListener( 'DOMContentLoaded', function() {
    const sidebarItemsCollection = document.querySelectorAll( '.sidebar-nav li' );
    const contentContainer = document.querySelector( '.content' );
    const sidebarItemsArr = Array.from(sidebarItemsCollection);

    sidebarItemsArr.forEach( item => {
        item.addEventListener('click', event => {
            const link = event.target;
            const text = link.innerText.toLowerCase();
            window.location.hash = text;
        });
    });

    const router = new Router( contentContainer );
    router.start();
})