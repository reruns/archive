window.JournalApp = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    this.posts = new JournalApp.Collections.Posts();
    this.posts.fetch({ success: function() {
      new JournalApp.Routers.Router({$rootEl: $('#everything')});
      Backbone.history.start();
    }});
  }
};

$(document).ready(function(){
  JournalApp.initialize();
});
