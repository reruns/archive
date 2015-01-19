$.Tabs = function (el) {
  this.$el = $(el);
  this.$contentTabs = this.$el.find('.content-tabs');
  this.$activeTab = this.$contentTabs.find('.active');

  console.log(this.$activeTab);

  this.$el.on('click','a', this.clickTab.bind(this));
};

$.Tabs.prototype.clickTab = function(event) {
  event.preventDefault();

  this.$activeTab.addClass('transitioning');
  this.$activeTab.one('transitionend', function() {
    $('.active').removeClass('active');
    this.$activeTab.removeClass('transitioning');
    var $target = $(event.currentTarget);
    $target.addClass('active');
    var linkId = $target.attr("href");
    this.$activeTab = this.$el.find(linkId);
    this.$activeTab.addClass('active transitioning');

    setTimeout(function() {
      this.$activeTab.removeClass('transitioning');
    }.bind(this), 0);
  }.bind(this));
};

$.fn.tabs = function () {
  return this.each(function () {
    new $.Tabs(this);
  });
};
