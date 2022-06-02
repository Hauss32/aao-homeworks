var board = require('./board');
var Board = board.Board;
var player = require('./player');
var Player = player.Player;

class Game {
    constructor(playerName1, playerName2){
        this.players = [new Player(playerName1, "X"), new Player(playerName2, "O")];
        this.currentPlayer = this.players[0];
        this.board = new Board();

        this.readline = require('readline');
        this.reader = this.readline.createInterface({
            input: process.stdin,
            output: process.stdout
        });
    }

    _togglePlayer() {
        if(this.currentPlayer === this.players[0]){
            this.currentPlayer = this.players[1];
        } else {
            this.currentPlayer = this.players[0];
        }
    }

    _getMove() {
        return new Promise( (res, rej) => {
            console.log(`\n${this.currentPlayer.name} (${this.currentPlayer.symbol}), it is your turn.`)
            this.reader.question('What cell do you want to mark? (e.g. `2,1`)', (resp) => {
                let coord = resp.split(',').map(num => parseInt(num));
                let result = this.board.placeSym(coord, this.currentPlayer.symbol);
                if (result) {
                    this.reader.pause();
                    res( console.log('Placing marker...') );
                } else {
                    rej( console.log('\n\n\n** Invalid move.') );
                }
            })
        })
    }

    _logGameOver(winner) {
        if (winner === 'draw') {
            console.log('\n—————————————————');
            console.log('——— TIE GAME! ———');
            console.log('—————————————————\n');
        } else if (winner) {
            console.log('\n—————————————————————');
            console.log(`${this.currentPlayer.name} WINS!!!`);
            console.log('—————————————————————\n');    
        } else {
            return;
        }
    }

    async play(endGameCallback) {
        this.board.print();
        
        try {
            await this._getMove();
        } catch (error) {
            return this.play(endGameCallback); //return early for user to try again
        }

        let isOverResult = this.board.checkWinner(this.currentPlayer.symbol);
        
        if (isOverResult) {
            this._logGameOver(isOverResult);
            this.reader.close();
            endGameCallback();
        } else {
            this._togglePlayer();
            this.play(endGameCallback);
        }
    }
}

let game = new Game('P1', 'P2');
game.play( () => {
    console.log('Thanks for playing!\n');
});