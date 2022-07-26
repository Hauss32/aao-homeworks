class Store {
    constructor(rootReudcer) {
        this.rootReudcer = rootReudcer;
        this.state = {};
    }

    getState() {
        return structuredClone(this.state);
    }
}