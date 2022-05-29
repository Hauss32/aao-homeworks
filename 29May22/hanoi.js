class Hanoi {
    constructor() {
        this.towers = [];

        this._resetGame();
    }

    run() {
        //until pieces are sequenced correctly on last tower
        //print board
        //ask user for move
        //move piece

        //congratulate winner when game over
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
}