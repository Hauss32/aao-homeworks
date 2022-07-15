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

    empty() {
        this.collection.forEach( elem => {
            elem.innerHTML = '';
        })
    }
}

module.exports = DomNodeCollection;