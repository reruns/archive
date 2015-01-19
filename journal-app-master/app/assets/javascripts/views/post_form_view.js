JournalApp.Views.PostFormView = Backbone.View.extend({
  template: JST['postForm'],


  initialize: function () {
    this.listenTo(this.model, "sync", function () {
      this.collection.add(this.model, {merge: true});
      //Backbone.history.navigate('/', {trigger: true});
    }.bind(this));
  },

  events: {
    'click button#post_form_button': 'submit'
  },

  submit: function (event, options) {
    event.preventDefault();
    this.model.save($('#post_form').serializeJSON(), {
      success: function () {
        Backbone.history.navigate('/', {trigger: true})
      },

      failure: function () {
        this.render();
      }
    })
  },

  render: function () {
    var content = this.template({post: this.model});
    this.$el.html(content);
    return this;
  }

})
