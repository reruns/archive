Pokedex.Router = Backbone.Router.extend({
  routes: {
    '': 'pokemonIndex',
    'pokemon/:id': 'pokemonDetail',
    'pokemon/:pokemonId/toys/:toyId': 'toyDetail'
  },

  pokemonDetail: function (id, callback) {
    if (this._pokemonIndex) {
      var poke = this._pokemonIndex.collection.get(id);
      this._pokemonDetail = new Pokedex.Views.PokemonDetail( {model: poke} );
      this._pokemonDetail.refreshPokemon({cb: callback});
      $("#pokedex .pokemon-detail").html(this._pokemonDetail.$el);
    } else {
      this.pokemonIndex(function() {
        this.pokemonDetail(id, callback)
      }.bind(this));
    }
  },

  pokemonIndex: function (callback) {
    this._pokemonIndex = new Pokedex.Views.PokemonIndex();
    this._pokemonIndex.refreshPokemon({cb: callback});
    $("#pokedex .pokemon-list").html(this._pokemonIndex.$el);
    this.pokemonForm();
  },

  toyDetail: function (pokemonId, toyId) {
    if (this._pokemonDetail && pokemonId == this._pokemonDetail.model.id) {
      var toy = this._pokemonDetail.model.toys().get(toyId);
      var toyDetail = new Pokedex.Views.ToyDetail({ model: toy, collection: this._pokemonIndex.collection});
      $("#pokedex .toy-detail").html(toyDetail.render().$el);
    } else {
      this.pokemonDetail(pokemonId, function() {
        this.toyDetail(pokemonId, toyId)
      }.bind(this));
    }
  },

  pokemonForm: function () {
    var mod = new Pokedex.Models.Pokemon();
    var pkForm = new Pokedex.Views.PokemonForm({
      model: mod,
      collection: this._pokemonIndex.collection
    });
    $("#pokedex .pokemon-form").html(pkForm.render().$el);
  }
});

$(function () {
  new Pokedex.Router();
  Backbone.history.start();
});
