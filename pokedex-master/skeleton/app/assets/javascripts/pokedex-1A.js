// pokemon = Models.Pokemon
Pokedex.RootView.prototype.addPokemonToList = function (pokemon) {
  var pokemonListItem = JST['pokemonListItem']({pokemon: pokemon});
  this.$pokeList.append(pokemonListItem);
};

// should fetch all the Pokemon by fetching this.pokes
Pokedex.RootView.prototype.refreshPokemon = function (callback) {
  var that = this;
  this.pokes.fetch({
    success: function() {
      that.pokes.each(function(poke) { that.addPokemonToList(poke); })
    }
  });
};
