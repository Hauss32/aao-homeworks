// DON'T TOUCH THIS CODE
if (typeof window === 'undefined'){
  var Piece = require("./piece");
}
// DON'T TOUCH THIS CODE

/**
 * Returns a 2D array (8 by 8) with two black pieces at [3, 4] and [4, 3]
 * and two white pieces at [3, 3] and [4, 4]
 */
function _makeGrid () {
  let gridSize = 8;
  let grid = [];

  for(let i = 0; i < gridSize; i++){
    grid.push(Array(8));
  }

  //set initial pieces
  grid[3][4] = new Piece('black');
  grid[4][3] = new Piece('black');
  grid[3][3] = new Piece('white');
  grid[4][4] = new Piece('white');

  return grid;
}

/**
 * Constructs a Board with a starting grid set up.
 */
function Board () {
  this.grid = _makeGrid();
}

Board.DIRS = [
  [ 0,  1], [ 1,  1], [ 1,  0],
  [ 1, -1], [ 0, -1], [-1, -1],
  [-1,  0], [-1,  1]
];

/**
 * Checks if a given position is on the Board.
 */
Board.prototype.isValidPos = function (pos) {
  let x = pos[0];
  let y = pos[1];
  let validX = x >= 0 && x <= 7; 
  let validY = y >= 0 && y <= 7; 

  return validX && validY;
};

/**
 * Returns the piece at a given [x, y] position,
 * throwing an Error if the position is invalid.
 */
Board.prototype.getPiece = function (pos) {
  if( !this.isValidPos(pos)){
    throw new Error('Not valid pos!');
  }

  let x = pos[0];
  let y = pos[1];
  let piece = this.grid[x][y];

  if(piece){
    return piece;
  } else{
    return undefined;
  }
};

/**
 * Checks if the piece at a given position
 * matches a given color.
 */
Board.prototype.isMine = function (pos, color) {
  let piece = this.getPiece(pos);

  if(piece){
    return piece.color === color;
  } else{
    return false;
  }
};

/**
 * Checks if a given position has a piece on it.
 */
Board.prototype.isOccupied = function (pos) {
  let piece = this.getPiece(pos);

  return !!piece;
};

/**
 * Recursively follows a direction away from a starting position, adding each
 * piece of the opposite color until hitting another piece of the current color.
 * It then returns an array of all pieces between the starting position and
 * ending position.
 *
 * Returns an empty array if it reaches the end of the board before finding another piece
 * of the same color.
 *
 * Returns empty array if it hits an empty position.
 *
 * Returns empty array if no pieces of the opposite color are found.
 */
Board.prototype._positionsToFlip = function(pos, color, dir, piecesToFlip=[]){
  let new_x = pos[0] + dir[0];
  let new_y = pos[1] + dir[1];
  let new_pos = [new_x, new_y];
  if( !this.isValidPos(new_pos) || this.getPiece(new_pos) === undefined ){
    return [];
  }

  if (this.getPiece(new_pos).color === color) {  
    return piecesToFlip;
  } else {
    piecesToFlip.push(new_pos);
  }
  
  let nextResult = this._positionsToFlip(new_pos, color, dir, piecesToFlip)

  if(nextResult.length === 0) { piecesToFlip = []; }
  
  return piecesToFlip;
};

/**
 * Checks that a position is not already occupied and that the color
 * taking the position will result in some pieces of the opposite
 * color being flipped.
 */
Board.prototype.validMove = function (pos, color) {
  if (this.isOccupied(pos)) { return false; }

  for(let i = 0; i < Board.DIRS.length; i++){
    let dir = Board.DIRS[i];
    let posToFlip = this._positionsToFlip(pos, color, dir);
    if (posToFlip.length > 0) { return true; }
  }

  return false;
};

/**
 * Adds a new piece of the given color to the given position, flipping the
 * color of any pieces that are eligible for flipping.
 *
 * Throws an error if the position represents an invalid move.
 */
Board.prototype.placePiece = function (pos, color) {
  if( !this.validMove(pos, color)){
    throw new Error('Invalid move!')
  }

  let x = pos[0];
  let y = pos[1];
  this.grid[x][y] = new Piece(color);

  Board.DIRS.forEach( dir => {
    let posToFlip = this._positionsToFlip(pos, color, dir);

    posToFlip.forEach( pos => {
      this.getPiece(pos).color = color;
    })
  })
};

/**
 * Produces an array of all valid positions on
 * the Board for a given color.
 */
Board.prototype.validMoves = function (color) {
  let gridLen = this.grid.length;
  let validMoves = [];

  for(let x = 0; x < gridLen; x++){
    for (let y = 0; y < gridLen; y++) {
      if( this.validMove([x,y], color)){
        validMoves.push([x,y]);
      }
    }
  }

  return validMoves;
};

/**
 * Checks if there are any valid moves for the given color.
 */
Board.prototype.hasMove = function (color) {
  return this.validMoves(color).length > 0;
};



/**
 * Checks if both the white player and
 * the black player are out of moves.
 */
Board.prototype.isOver = function () {
  return !this.hasMove('white') && !this.hasMove('black');
};




/**
 * Prints a string representation of the Board to the console.
 */
Board.prototype.print = function () {
  this.grid.forEach( row => {
    let rowStr = '';
    row.forEach( piece => {
      let pieceStr = piece ? piece.toString() : '_';
      rowStr += pieceStr;
    })

    console.log(rowStr);
  })
};


// DON'T TOUCH THIS CODE
if (typeof window === 'undefined'){
  module.exports = Board;
}
// DON'T TOUCH THIS CODE