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

    toString() {
        const finalStrLen = 15;
        const leftStr = '='.repeat(this.size);
        const rightStr = leftStr;
        const totalStr = `${leftStr}|${rightStr}`;
        const paddingAmount = (finalStrLen - totalStr.length) / 2;
        const paddingStr = ' '.repeat(paddingAmount);

        return `${paddingStr}${totalStr}${paddingStr}`;
    }
}

module.exports = {
    Piece: Piece
};