class PostsController < ApplicationController

  def create
    @post = Post.new(post_params)
    if @post.save
      render json: @post
    end
  end

  def index
    @posts = Post.all
    render json: @posts
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    head 200
  end

  def show
    @post = Post.find(params[:id])
    render json: @post
  end

  def new
    @post = Post.new
    render json: @post
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    render json: @post
  end

  private
  def post_params
    params.require('post').permit([:title, :body])
  end
end
