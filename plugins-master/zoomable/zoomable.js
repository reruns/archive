$.Zoomable = function(el) {
  this.$el = $(el);
  this.focusSize = 400;
  this.$focusBox = $('.focus-box')

  //$('div.zoomable img').on('mouseenter', this.showFocusBox.bind(this));
  $('div.zoomable img').on('mousemove', this.moveFocusBox.bind(this));
  //$('div.zoomable img').on('mouseleave', this.removeFocusBox.bind(this));
}

$.Zoomable.prototype.showFocusBox = function(event) {
  this.$focusBox = $("<div class='focus-box'></div>");
  this.$el.append(this.$focusBox);
}

$.Zoomable.prototype.moveFocusBox = function(event) {
  this.$focusBox.css('left',event.pageX);
  this.$focusBox.css('top', event.pageY);
}

$.Zoomable.prototype.removeFocusBox = function(event) {
  this.$focusBox.remove();
  this.$focusBox = null;
}

$.fn.zoomable = function () {
  return this.each(function () {
    new $.Zoomable(this);
  });
};
