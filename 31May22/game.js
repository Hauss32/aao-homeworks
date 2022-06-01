class Game {
    constructor(playerName1, playerName2){
        this.players = [new Player(playerName1, "X"), new Player(playerName2, "O")];
        this.currentPlayer = this.players[0];
        this.board = new Board();
    }

    _togglePlayer() {
        if(this.currentPlayer === this.players[0]){
            this.currentPlayer = this.players[1];
        } else {
            this.currentPlayer = this.players[0];
        }
    }
}