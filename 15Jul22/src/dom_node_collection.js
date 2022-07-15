class DomNodeCollection {
    constructor(collection) {
        this.collection = collection;
    }

    html(str) {
        if (str) {
            this.collection.forEach( elem => {
                elem.innerHTML = str;
            })
        } else {
            return this.collection[0].innerHTML;
        }
    }
}

module.exports = DomNodeCollection;