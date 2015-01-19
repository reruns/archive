//require('./playTicTacToe.js')
"use strict";
var TTT = require('./ttt');

var readline = require('readline');
var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

var game = new TTT.Game();
game.run(reader, function() {
  reader.close();
});
