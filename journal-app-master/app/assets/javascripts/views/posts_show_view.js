JournalApp.Views.PostsShowView = Backbone.View.extend({
  template: JST["postShow"],

  render: function() {
    var content = this.template({post: this.model});
    this.$el.html(content);
    return this;
  },

  events: {
    "dblclick h1.title": "editTitle",
    "dblclick pre.body": "editBody",
    "blur input.title": "saveNewTitle",
    "blur textarea.body": "saveNewBody"
  },

  editTitle: function () {
    var $target = $(event.target);
    $target.html('<input class="title" name="post[title]" value="' + $target.text() + '">')
  },

  saveNewTitle: function () {
    var $target = $(event.target);
    this.model.save({title: $target.val()});
    this.render();
  },

  editBody: function () {
    var $target = $(event.target);
    $target.html('<textarea class="body" name="post[body]">' + $target.text() + '</textarea>');
  },

  saveNewBody: function () {
    var $target = $(event.target);
    this.model.save({body: $target.val()});
    this.render();
  }

});
