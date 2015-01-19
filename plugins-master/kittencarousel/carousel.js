$.Carousel = function(el) {
  this.$el = $(el);
  this.activeIdx = 1;
  $('div.items img:first-child').addClass('active');
  this.itemSize = $('div.items img').length;
  this.transitioning = false;

  $('.slide-left').on('click', this.slideLeft.bind(this));
  $('.slide-right').on('click', this.slideRight.bind(this));
}

$.Carousel.prototype.slideLeft = function(event) {
  this.slide(1);
}

$.Carousel.prototype.slideRight = function(event) {
  this.slide(-1);
}

$.Carousel.prototype.slide = function(num) {
  if (this.transitioning) {
    return;
  }
  this.transitioning = true;
  var currItem = $('div.items img:nth-child('+this.activeIdx+')');
  var currClass = num === -1 ? 'left' : 'right';
  currItem.addClass(currClass);
  currItem.one("transitionend", function() {
    currItem.removeClass('active');
    currItem.removeClass(currClass);
    this.transitioning = false;
  }.bind(this))

  this.activeIdx = (this.activeIdx + num) % (this.itemSize);
  if (this.activeIdx <= 0) {
    this.activeIdx += (this.itemSize);
  }

  var nextItem = $('div.items img:nth-child('+this.activeIdx+')');
  nextItem.addClass('active');
  var nextClass = num == 1 ? 'left' : 'right';
  nextItem.addClass(nextClass);
  setTimeout(function(){
    nextItem.removeClass(nextClass);
  }, 0);
}

$.fn.carousel = function () {
  return this.each(function () {
    new $.Carousel(this);
  });
};
