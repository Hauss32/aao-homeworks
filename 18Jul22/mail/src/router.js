class Router {
    constructor(node, routes) {
        this.node = node;
        this.routes = routes;
    }

    start() {
        window.addEventListener( 'hashchange', () => {
            this.render();
        })

        this.render();
    }

    activeRoute() {
        let route = window.location.hash;
        route = route.replace( '#', ''); //remove '#' prefix in route

        return this.routes[route];
    }

    render() {
        const component = this.activeRoute();
        this.node.innerHTML = "";

        if ( component ) {
            const messagesElem = component.render();
            this.node.appendChild( messagesElem );
        }
    }
}

module.exports = Router;