//require('./clock.js')
function Clock () {
  this.currentTime = new Date();
}

Clock.TICK = 5000;

Clock.prototype.printTime = function () {
  var hour = this.currentTime.getHours();
  var minute = this.currentTime.getMinutes();
  var second = this.currentTime.getSeconds();
  console.log(hour+":"+minute+":"+second);
  // Format the time in HH:MM:SS
};

Clock.prototype.run = function () {
  var that = this;
  this.printTime();
  setInterval(function(){that._tick()}, 5000);
  // 1. Set the currentTime.
  // 2. Call printTime.
  // 3. Schedule the tick interval.
};

Clock.prototype._tick = function () {
  this.currentTime.setMilliseconds(5000);
  this.printTime();
  // 1. Increment the currentTime.
  // 2. Call printTime.
};

var clock = new Clock();
clock.run();
