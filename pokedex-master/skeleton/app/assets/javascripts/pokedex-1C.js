Pokedex.RootView.prototype.createPokemon = function (attrs, callback) {
  var pokemon = new Pokedex.Models.Pokemon();
  pokemon.save(attrs, {
    success: function(model, response, options) {
      this.pokes.add(model);
      this.addPokemonToList(model);
      callback(model);
    }.bind(this)
  })
};

Pokedex.RootView.prototype.submitPokemonForm = function (event) {
  event.preventDefault();
  var formJSON = $(event.target).serializeJSON();
  this.createPokemon(formJSON, this.renderPokemonDetail.bind(this));
};
