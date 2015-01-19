JournalApp.Routers.Router = Backbone.Router.extend({

  initialize: function (options) {
    this.$rootEl = options.$rootEl;
    this.$sidebar = this.$rootEl.find('#sidebar');
    this.$content = this.$rootEl.find('#content');

    this.sidebarView = new JournalApp.Views.PostsIndexView({
      collection: JournalApp.posts
    });
    this.$sidebar.html(this.sidebarView.render().$el);
  },

  routes: {
    '': 'index',
    'posts/new': 'new',
    'posts/:id': 'show',
  },

  index: function () {
    this.$content.html("<h2>Hi, this is the index page.</h2>");
  },

  show: function (id) {
    var that = this;
    var post = JournalApp.posts.getOrFetch(id)
    var showView = new JournalApp.Views.PostsShowView({
        model: post
    })

    that.$content.html(showView.render().$el);

    showView.listenTo(post, "sync", function() {
      that.$content.html(showView.render().$el)
    });
  },

  new: function () {
    var post = new JournalApp.Models.Post();
    var postFormView = new JournalApp.Views.PostFormView({
      model: post,
      collection: JournalApp.posts
    });
    this.$content.html(postFormView.render().$el);
  }
});
