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

    append(data) {
        if (data instanceof DomNodeCollection) {
            data.collection.forEach( elem => {
                const dataToAppend = elem.outerHTML;

                this.collection.forEach( domElem => {
                    domElem.innerHTML += dataToAppend;
                })
            })
        } else if (data instanceof HTMLElement) {
            this.collection.forEach( domElem => {
                domElem.innerHTML += data.outerHTML;
            } )    
        } else {
            this.collection.forEach(domElem => {
                domElem.innerHTML += data;
            })   
        }
    }
}

module.exports = DomNodeCollection;