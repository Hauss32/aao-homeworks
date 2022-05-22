/**
 * Initializes the Piece with its color.
 */
function Piece (color) {
    const COLORS = ['black', 'white']

    if(COLORS.includes(color)){
        this.color = color;
    } else{
        throw `${color} is not a valid piece color (black, white)`;
    }
}

/**
 * Returns the color opposite the current piece.
 */
Piece.prototype.oppColor = function () {
    return this.color === 'white' ? 'black' : 'white';
};

/**
 * Changes the piece's color to the opposite color.
 */
Piece.prototype.flip = function () {
    this.color = this.oppColor();
};

/**
 * Returns a string representation of the piece
 * based on its color.
 */
Piece.prototype.toString = function () {
    return this.color === 'white' ? 'W' : 'B';
};

// DON'T TOUCH THIS CODE
if (typeof window === 'undefined'){
    module.exports = Piece;
}
// DON'T TOUCH THIS CODE