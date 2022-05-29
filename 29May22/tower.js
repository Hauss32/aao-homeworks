class Tower {
    constructor() {
        this.pieces = [];
    }

    pop() {
        return this.pieces.pop();
    }

    peek(){
        let lastIdx = this.pieces.length -1;
        return this.pieces[lastIdx];
    }

    add(piece) {
        let lastPiece = this.peek();
        if (lastPiece === undefined || lastPiece.isBigger(piece)) {
            this.pieces.push(piece);
            return true;
        } else {
            return false;
        }
    }

    setStartingPieces() {
        this.pieces = [];
        this._orderedSizes.forEach( size => {
            let piece = new Piece(size);
            this.add(piece);
        })
    }

    clear() {
        this.pieces = [];
    }

    movePiece(otherTower) {
        if( this._isValidMove(otherTower) ) {
            otherTower.add( this.pop() );
            return true;
        } else {
            return false;
        }
    }

    hasOrderedPieces() {
        if (this.pieces.length < 5) {
            return false;
        } else {
            let sizeOrder = this.pieces.map( piece => piece.size );
            let correctOrder = this._orderedSizes();

            for (let i = 0; i < correctOrder.length; i++) {
                if( sizeOrder[i] !== correctOrder[i]) {
                    return false;
                }
            }

            return true;
        }
    }

    _orderedSizes() {
        return [5, 4, 3, 2, 1];
    }

    _isValidMove(otherTower) {
        let otherPiece = otherTower.peek();
        let thisPiece = this.peek();

        if(otherPiece === undefined) {
            return true;
        } else if (thisPiece === undefined) {
            return false;
        } else {
            return otherPiece.isBigger(thisPiece) ? true : false;
        }
    }
}