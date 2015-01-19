JournalApp.Views.PostsListView = Backbone.View.extend({
  template: JST["postsList"],
  tagName: 'li',
  render: function() {
    var content = this.template({post: this.model});
    this.$el.html(content);
    return this;
  }
});
