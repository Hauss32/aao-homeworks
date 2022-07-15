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

    attr(name, value) {
        this.collection.forEach( elem => {
            elem.setAttribute(name, value);
        })
    }

    addClass(className) {
        this.collection.forEach( elem => {
            elem.classList.add(className);
        })
    }

    removeClass(className) {
        this.collection.forEach(elem => {
            elem.classList.remove(className);
        })
    }

    children() {
        let children = [];

        this.collection.forEach( elem => {
            const childrenArr = Array.from( elem.children );
            children = children.concat( childrenArr );
        })

        return new DomNodeCollection( children );
    }

    parent() {
        const parents = [];

        this.collection.forEach( elem => {
            const parent = elem.parentElement;
            
            if ( !parents.includes( parent ) ) {
                parents.push( elem.parentElement );
            }
        })

        return new DomNodeCollection(parents);
    }
}

module.exports = DomNodeCollection;