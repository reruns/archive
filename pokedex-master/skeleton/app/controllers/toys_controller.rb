class ToysController < ApplicationController

  def show
    @toy = Toy.find(params[:id])
  end

  def update
    @toy = Toy.find(params[:id])

    if @toy.update(toy_params)
      render json: @toy
    else
      render json: @toy.errors
    end
  end

  private

  def toy_params
    params.require(:toy).permit(:pokemon_id, :happiness, :price, :image_url, :id)
  end
end
