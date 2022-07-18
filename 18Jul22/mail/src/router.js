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

    }
}