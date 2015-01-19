function Board() {
  this.grid = [[],[],[]];
  this.winner = ""
}

Board.prototype.won = function() {
  return (this.rowWin()
       || this.colWin()
       || this.diagWin());
};

Board.prototype.rowWin = function() {
  for (var i = 0; i < 3; i++ ) {
    if (this.empty([i,0]))
      continue;

    if ((this.grid[i][0] == this.grid[i][1]
        && this.grid[i][1] == this.grid[i][2])) {
      this.winner = this.grid[i][0]
      return true;
    }
  };
  return false;
};

Board.prototype.colWin = function() {
  for (var i = 0; i < 3; i++ ) {
    if (this.empty([0,i]))
      continue;

    if ((this.grid[0][i] == this.grid[1][i]
      && this.grid[1][i] == this.grid[2][i])) {
      this.winner = this.grid[0][i]
      return true;
    }
  };
  return false;
};

Board.prototype.diagWin = function() {
  if (!this.grid[1][1])
    return false;

  if ((this.grid[0][0] == this.grid[1][1]
    && this.grid[1][1] == this.grid[2][2])
   || (this.grid[2][0] == this.grid[1][1]
    && this.grid[1][1] == this.grid[0][2])) {

    this.winner = this.grid[1][1];
    return true;
  }
};

Board.prototype.empty = function(pos) {
  x = pos[0];
  y = pos[1];
  return !this.grid[x][y];
};

Board.prototype.place_mark = function(pos,mark) {
  x = pos[0];
  y = pos[1];
  this.grid[x][y] = mark;
};

Board.prototype.print = function() {
  for (var i = 0; i < 3; i++) {
    var rowstr = ""
    for(var j = 0; j < 3; j++) {
      if(this.grid[i][j] != "X" && this.grid[i][j] != "O")
        rowstr += " ";
      else rowstr += this.grid[i][j];
    }
    console.log(rowstr);
  }
};

Board.prototype.cat = function() {
  if (this.won())
    return false;

  for (var i = 0; i < 3; i++) {
    for (var j = 0; j < 3; j++) {
      if (!this.grid[i][j])
        return false;
    }
  }
  return true;
};

Board.prototype.move = function(pos, mark) {
  if (pos[0] < 0 || pos[0] >= 3 || pos[1] < 0 || pos[1] >= 3)
    return false;

  if (this.empty(pos)) {
    this.place_mark(pos,mark);
    return true;
  } else return false;

};

module.exports = Board;
