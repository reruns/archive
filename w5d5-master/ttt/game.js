var Board = require('./board');
function Game() {
  this.board = new Board();
  this.currentMark = "X"
}

Game.prototype.run = function(reader, gameOverCallback) {
  var that = this;
  this.promptMove(reader, function(pos) {
    if (that.board.move(pos, that.currentMark))
      that.currentMark = that.currentMark == 'X' ? 'O' : 'X';

    if (!that.board.won() && !that.board.cat())
      that.run(reader, gameOverCallback);
    else {
      if (that.board.winner != "")
        console.log("CONGRATS, " + that.board.winner + "! YOU WIN!");
      else
        console.log("Nobody wins.");

      gameOverCallback();
    }
  });
}

Game.prototype.promptMove = function(reader, callback) {
  this.board.print();
  reader.question("Enter your move\n", function(moveStr){
    var pos = parseMove(moveStr)
    callback(pos);
  });
};

var parseMove = function(moveStr) {
  var moves = moveStr.split(',');
  var p = moves.map(function(mov) {
    return parseInt(mov);
  });
  return p;
};

module.exports = Game;
