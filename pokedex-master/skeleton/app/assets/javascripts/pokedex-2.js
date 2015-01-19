Pokedex.RootView.prototype.addToyToList = function (toy) {
  var toyListItem = JST['toyListItem']({toy: toy});

  this.$pokeDetail.find('ul.toys').append(toyListItem);
};

Pokedex.RootView.prototype.renderToyDetail = function (toy) {
  this.$toyDetail.empty();
  var toyDetail = JST['toyDetail']({ toy: toy, pokes: this.pokes });
  this.$toyDetail.append(toyDetail);
};

Pokedex.RootView.prototype.selectToyFromList = function (event) {
  var pokeId = $(event.currentTarget).data("pokemon-id");
  var toyId = $(event.currentTarget).data("toy-id");
  var pokemon = new Pokedex.Models.Pokemon({ id: pokeId });
  pokemon.fetch({
    success: function(model, res, options) {
      var toy = pokemon.toys().get(toyId);
      this.renderToyDetail(toy);
    }.bind(this)
  });

};
