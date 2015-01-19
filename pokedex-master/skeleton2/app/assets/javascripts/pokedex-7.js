Pokedex.Views = (Pokedex.Views || {});

Pokedex.Views.PokemonForm = Backbone.View.extend({
  events: {
    'submit form.new-pokemon': 'savePokemon'
  },

  //this.$el.on('submit', form.new-pokemen, this['savePokemon'].b

  render: function () {
    this.$el.html(JST.pokemonForm());
    return this;
  },

  savePokemon: function (event) {
    var data = $(event.currentTarget).serializeJSON();
    this.model.save(data, {
      success: function() {
        this.collection.add(this.model);
        Backbone.history.navigate('pokemon/'+this.model.id, {trigger: true });
      }.bind(this)
    })
  }
});
