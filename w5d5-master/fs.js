Function.prototype.myBind = function(context) {
  var fn = this;
  return function() {
    fn.apply(context);
  };
}

//ok?
//Telling me exactly what to do was dumb.
