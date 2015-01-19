JournalApp.Views.PostsIndexView = Backbone.View.extend({
  template: JST["postsIndex"],
  initialize: function(options) {
    this.listenTo(this.collection, "add", function(model) {
      this.render();
      Backbone.history.navigate("posts/"+model.id, {trigger: true});
    });

    this.listenTo(this.collection, "remove change:title reset sync", this.render);
  },
  tagName: 'ul',

  render: function() {
    var content = this.template();
    this.$el.html(content);
    var that = this;
    this.collection.each(function (post) {
      var view = new JournalApp.Views.PostsListView({model: post });
      that.$el.append(view.render().$el);
    });
    return this;
  },

  events: {
    "click button.delete-button": "deletePost"
  },

  deletePost: function(event) {
    var postId = $(event.currentTarget).data('id');
    this.collection.get(postId).destroy();
  }
});
