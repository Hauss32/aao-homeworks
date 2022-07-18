class Router {
    constructor(node) {
        this.node = node;
    }

    start() {
        document.addEventListener( 'hashchange', () => {
            this.render();
        })

        this.render();
    }

    activeRoute() {

    }

    render() {
        const currRoute = this.activeRoute();
        const routeElem = document.createElement( 'p' );

        routeElem.innerHTML = currRoute;
        this.node.innderHTML = "";
        this.node.appendChild( routeElem );


    }
}