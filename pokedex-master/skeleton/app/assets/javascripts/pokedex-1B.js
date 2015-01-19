Pokedex.RootView.prototype.renderPokemonDetail = function (pokemon) {
  pokemon.fetch({
    success: function () {
      $("div.pokemon-detail").empty();

      var pokemonDetail = JST['pokemonDetail']({pokemon: pokemon});
      $("div.pokemon-detail").append(pokemonDetail);

      this.renderToysList(pokemon.toys());

    }.bind(this)
  })

};

Pokedex.RootView.prototype.selectPokemonFromList = function (event) {
  var id = $(event.target).data('id');
  var pokemon = this.pokes.get({ id: id });
  this.renderPokemonDetail(pokemon);
};
