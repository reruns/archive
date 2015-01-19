$.Thumbnails = function(el) {
  this.$el = $(el);
  this.$activeImg = $('div.gutter-images img:first-child')
  this.activate(this.$activeImg);
  this.gutterIdx = 0;
  this.$images = $('div.gutter-images img');
  this.fillGutterImages();

  $('a.nav').on('click', function() {
    var $nav = $(event.currentTarget)
    if ($nav.hasClass('right')) {
      if (this.gutterIdx < this.$images.length - 5){
        this.gutterIdx += 1;
        this.fillGutterImages();
      }
    } else {
      if (this.gutterIdx > 0) {
        this.gutterIdx -= 1;
        this.fillGutterImages();
      }
    }
  }.bind(this))
}

$.Thumbnails.prototype.bindImgEvents = function () {
  $('div.gutter-images img').on('click', function(){
    this.$activeImg = $(event.currentTarget);
    this.activate(this.$activeImg);
  }.bind(this));

  $('div.gutter-images img').on('mouseenter', function(){
    this.activate($(event.currentTarget));
  }.bind(this));

  $('div.gutter-images img').on('mouseleave', function(){
    this.activate(this.$activeImg);
  }.bind(this));
}

$.Thumbnails.prototype.activate = function($img){
  $('div.active img').remove();
  $clone = $img.clone();
  $clone.addClass('active');
  $('div.active').append($clone);
}

$.Thumbnails.prototype.fillGutterImages = function() {
  $('div.gutter-images img').remove();
  for (var i = this.gutterIdx; i < this.gutterIdx+  5; i++) {
    $('div.gutter-images').append(this.$images[i]);
  }
  this.bindImgEvents();
}

$.fn.thumbnails = function () {
  return this.each(function () {
    new $.Thumbnails(this);
  });
};
