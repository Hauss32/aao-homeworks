class Piece {
    constructor(size) {
        this.size = this._setSize(size);
    }

    _setSize(size) {
        if(size > 0 && size < 6){
            return size;
        } else {
            throw new Error(`${size} is not a valid size.`)
        }
    }

    isBigger(other) {
        return (this.size > other.size) ? true : false;
    }
}