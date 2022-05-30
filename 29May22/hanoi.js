const tower = require('./tower');
const Tower = tower.Tower;
const readline = require('readline');
const reader = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

class Hanoi {
    constructor() {
        this.towers = [];

        this._resetGame();
    }

    async run() {   
            console.log('\n\n\n~~~~~~~~~~~~~~~~~~~~~~~');
            console.log('~|  Towers of Hanoi  |~');
            console.log('~~~~~~~~~~~~~~~~~~~~~~~');

            const playRound = async () => {
                let move = await this._getMove();

                try {
                    this._makeMove(move);
                } catch (error) {
                    console.log('\n** Invalid input. **');
                }

            }

            while ( !this._isOver() ) {
                this._print();
                await playRound();
            }

            this._print();
            console.log('\n~~~~~~~~~~~~~~~~~~~~~~~');
            console.log('~~~~~  WINNER!!!  ~~~~~');
            console.log('~~~~~~~~~~~~~~~~~~~~~~~');
            reader.close();
    }

    _resetAllTowers() {
        if (this.towers.length === 3) {
            this.towers.forEach( tower => tower.clear() );
        } else {
            this.towers = [];
            for (let i = 0; i < 3; i++) {
                let tower = new Tower();
                this.towers.push(tower);
            }
        }
    }

    _resetFirstTower() {
        let firstTower = this.towers[0];

        if( firstTower ) {
            firstTower.setStartingPieces();
        }
    }

    _resetGame() {
        this._resetAllTowers();
        this._resetFirstTower();
    }

    _isOver() {
        let lastTower = this.towers[ this.towers.length - 1 ];

        return lastTower.hasOrderedPieces();
    }


    _getMove() {
        return new Promise( (res, rej) => {
            let move = [];
            let fromTowerNum;
            let toTowerNum;

            reader.question('What tower would you like to move a piece from? (`1`, `2` or `3`)', resp => {
                fromTowerNum = parseInt(resp, 10);
                let fromTowerIdx = fromTowerNum - 1;
                move.push(this.towers[fromTowerIdx]);
                reader.question('What tower would you like to move the piece to? (`1`, `2` or `3`)', resp => {
                    toTowerNum = parseInt(resp, 10);
                    let toTowerIdx = toTowerNum - 1;
                    move.push(this.towers[toTowerIdx]);
                    console.log(`Moving a piece from Tower #${fromTowerNum} to Tower #${toTowerNum}...\n`);
                    reader.pause();

                    if (move.length === 2) {
                        res(move)
                    } else {
                        rej(move);
                    }
                })
            })
        });
    }


    _makeMove(move) {
        const [ fromTower, toTower ] = move;
        const result = fromTower.movePiece(toTower);

        if( !result ) {
            console.log('\n** Invalid move. Please try again. **\n')
        }
        return result;
    }

    _print() {
        const towerPrintableArrs = [];
        const towerDelimStr = '     ';
        this.towers.forEach( tower => towerPrintableArrs.push( tower.toPrintableArr() ) );

        console.log('_'.repeat(55));
        console.log(`Current Board:\n`);

        for (let i = 4; i >= 0; i--) {
            let strsToLog = [];
            
            towerPrintableArrs.forEach( towerArrStr => strsToLog.push(towerArrStr[i]) );
            console.log( strsToLog.join(towerDelimStr) );
        }

        console.log('_'.repeat(55));
        console.log(`${' '.repeat(4)}Tower 1${' '.repeat(13)}Tower 2${' '.repeat(13)}Tower 3\n`);
    }
}

let h = new Hanoi();
h.run();