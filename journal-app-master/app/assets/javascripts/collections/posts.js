JournalApp.Collections.Posts = Backbone.Collection.extend({
  url: "posts",
  model: JournalApp.Models.Post,

  getOrFetch: function (id) {
    var model;
    // debugger;

    if (this.get(id)) {
      model = this.get(id);
    }
    else
    {
      model = new this.model({
        id: id
      });
      this.add(model);
      model.fetch();
    }
    return model;
  }
})
