//require('./addNumbers.js')

var readline = require('readline');
var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

var addNumbers = function(sum, numsLeft, completionCallback) {
  if(numsLeft > 0) {
    reader.question("Enter a number", function(numString) {
      var num = parseInt(numString);
      sum += num;
      console.log("So far: " + sum);
      addNumbers(sum, numsLeft-1, completionCallback)
    });
  } else {
    completionCallback(sum);
  }
}

addNumbers(0,2,function(sum) {
  console.log("The final sum is: "+sum);
  reader.close();
});
