class Board {
    constructor() {
        this.grid;
        this.freeCells;

        this._resetBoard();
    }

    print() {
        console.log('\n·Tic-Tac-Toe·');
        this.grid.forEach( (row, idx) => {
            let rowStrArr = row.map( cell => (cell !== ' ') ? ` ${cell} ` : '   ' );
            console.log(' ' + rowStrArr.join('|'));
            if (idx < 2) {
                console.log(' ————————————');
            }
        })

        console.log('');
    }

    _isValidMove(coord) {
        const [x,y] = coord;
        if ([0,1,2].includes(x) && [0,1,2].includes(y)){
            return true;
        } else {
            return false;
        }
    }

    placeSym(coord, sym) {
        if ( !this._isValidMove(coord) ) {
            return false;
        }

        const [x,y] = coord;
        const cell = this.grid[x][y];

        if(cell !== ' '){
            return false;
        } else {
            this.grid[x][y] = sym;
            this.freeCells -= 1;
            return true;
        }
    }

    checkWinner(sym) {
        if (this.freeCells === 0) {
            return 'draw';
        } else if (this._hasWinner(sym)) {
            return sym;
        }

        return false;
    }

    _isRowWin(sym) {
        for(let i = 0; i < this.grid.length; i++) {
            let row = this.grid[i]
            let firstVal = row[0];
            if (firstVal !== sym) {
                continue;
            } else {
                if (row.every( ele => ele === sym )) {
                    return sym;
                }
            }
        }

        return false;
    }

    _isColWin(sym) {
        for (let i = 0; i < this.grid.length; i++) {
            let col = this.grid.map( row => row[i] )
            let firstVal = col[0];
            if (firstVal !== sym) {
                continue;
            } else {
                if (col.every(ele => ele === sym)) {
                    return sym;
                }
            }
        }
    }

    _isDiagWin(sym) {
        const diags = [
            [ [0,0], [1,1], [2,2] ], 
            [ [0,2], [1,1], [2,0] ]
        ]
        let hasWinDiag = false;

        diags.forEach( diag => {
            let cells = diag.map( coord => {
                let [x,y] = coord;
                return this.grid[x][y];
            })
            let firstVal = cells[0];
            if (firstVal !== sym) {
                //do nothing
            } else {
                if (cells.every(ele => ele === sym)) {
                    hasWinDiag = sym;
                }
            }
        })

        return hasWinDiag;
    }

    _hasWinner(sym) {
        return this._isRowWin(sym) || this._isColWin(sym) || this._isDiagWin(sym);
    }

    _resetBoard() {
        this.grid = Array(3);
        for (let i = 0; i < this.grid.length; i++) {
            this.grid[i] = Array(3).fill(' ');
        }

        this.freeCells = 9;
    }

}

module.exports = {
    Board: Board
};