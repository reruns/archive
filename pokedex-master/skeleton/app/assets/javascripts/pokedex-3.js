Pokedex.RootView.prototype.submitToyForm = function (event) {
  event.preventDefault();
  var $form = $(event.currentTarget);
  var formJSON = $form.serializeJSON();
  var $currentToyId = $form.data("toy-id");
  var $currentPokeId = $form.data("pokemon-id");
  var oldPoke = this.pokes.get($currentPokeId);

  var currentToy = oldPoke.toys().get($currentToyId);

  // var oldPoke = this.pokes.get($currentTarget.data("pokemon-id"));
  // var currentToy = oldPoke.toys().get($currentTarget.data("toy-id"));
  // currentToy.set("pokemon_id", $currentTarget.val());
  currentToy.save(formJSON, {
    success: function (model) {
      oldPoke.toys().remove(currentToy);
      this.renderToysList(oldPoke.toys());
      console.log(model);
      this.$toyDetail.empty();
    }.bind(this)
  });
}

Pokedex.RootView.prototype.renderToysList = function (toys) {
  this.$pokeDetail.find(".toys").empty();
  toys.forEach(function (toy) {
    this.addToyToList(toy);
  }.bind(this));
}
