//require('./hanoi.js')
var readline = require('readline');
var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function Hanoi(size) {
  this.stacks = [[3,2,1],[],[]];
};

Hanoi.prototype.isWon = function() {
  return this.stacks[1].length == 0 && this.stacks[0].length == 0;
};

Hanoi.prototype.isValidMove = function(startIdx, endIdx) {
  start = this.stacks[startIdx];
  end = this.stacks[endIdx];
  return start.length != 0 && (end.length == 0 || start[start.length-1] < end[end.length-1]);
};

Hanoi.prototype.move = function(startIdx, endIdx) {
  if (this.isValidMove(startIdx, endIdx)) {
    this.stacks[endIdx].push(this.stacks[startIdx].pop());
    return true;
  }
  return false;
};

Hanoi.prototype.print = function() {
  console.log(JSON.stringify(this.stacks));
};

Hanoi.prototype.promptMove = function(callback) {
  this.print();
  reader.question("Starting tower?", function(startString){
    reader.question("Ending tower?", function(endString){
      var start = parseInt(startString);
      var end = parseInt(endString);
      callback(start,end);
    });
  });
};

Hanoi.prototype.run = function(completionCallback) {
  var that = this;
  this.promptMove(function(start, end){
    if (!that.move(start, end)) {
      console.log("failed to perform move.");
    }
    if (!that.isWon()) {
      that.run(completionCallback);
    } else {
      completionCallback();
    }
  });
};

var game = new Hanoi();
game.run(function () {
  reader.close();
});
