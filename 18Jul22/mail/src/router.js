class Router {
    constructor(node) {
        this.node = node;
    }

    start() {
        window.addEventListener( 'hashchange', () => {
            this.render();
        })

        this.render();
    }

    activeRoute() {
        const route = window.location.hash;

        return route.replace( '#', ''); //remove '#' prefix in route
    }

    render() {
        const currRoute = this.activeRoute();
        const routeElem = document.createElement( 'p' );

        this.node.innerHTML = "";
        routeElem.innerHTML = currRoute;
        this.node.appendChild( routeElem );
    }
}

module.exports = Router;