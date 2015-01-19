window.Pokedex = (window.Pokedex || {});
window.Pokedex.Models = {};
window.Pokedex.Collections = {};

// WRITE ME
Pokedex.Models.Pokemon = Backbone.Model.extend({
  urlRoot: '/pokemon',

  toys: function() {
    if (typeof this._toys === 'undefined') {
      this._toys = new Pokedex.Collections.PokemonToys([], { pokemon: this })
    }
    return this._toys;
  },

  parse: function(payload) {
    if (payload.toys) {
      this.toys().set(payload.toys);
      delete payload.toys;
    }
    return payload;
  }
});

// WRITE ME IN PHASE 2
Pokedex.Models.Toy = Backbone.Model.extend({
  urlRoot: '/toys'
});

Pokedex.Collections.Pokemon = Backbone.Collection.extend({
  url: '/pokemon',
  model: Pokedex.Models.Pokemon
});

Pokedex.Collections.PokemonToys = Backbone.Collection.extend({
  model: Pokedex.Models.Toy
})

window.Pokedex.Test = {
  testShow: function (id) {
    var pokemon = new Pokedex.Models.Pokemon({ id: id });
    pokemon.fetch({
      success: function () {
        console.log(pokemon.toJSON());
      }
    });
  },

  testIndex: function () {
    var pokemon = new Pokedex.Collections.Pokemon();
    pokemon.fetch({
      success: function () {
        console.log(pokemon.toJSON());
      }
    });
  }
};

window.Pokedex.RootView = function ($el) {
  this.$el = $el;
  this.pokes = new Pokedex.Collections.Pokemon();
  this.$pokeList = this.$el.find('.pokemon-list');
  this.$pokeDetail = this.$el.find('.pokemon-detail');
  this.$newPoke = this.$el.find('.new-pokemon');
  this.$toyDetail = this.$el.find('.toy-detail');

  // Click handlers go here.
  this.$el.on('click', 'li.poke-list-item', this.selectPokemonFromList.bind(this));

  this.$el.on('submit', 'form.new-pokemon', this.submitPokemonForm.bind(this));

  this.$el.on('click', 'ul.toys li', this.selectToyFromList.bind(this));
  // select box in RenderToyDetail
  this.$el.on('submit', 'form.toy-detail-form', this.submitToyForm.bind(this));
};

$(function() {
  var $rootEl = $('#pokedex');
	window.Pokedex.rootView = new Pokedex.RootView($rootEl);
  window.Pokedex.rootView.refreshPokemon();
});
