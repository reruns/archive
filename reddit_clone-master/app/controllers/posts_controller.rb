class PostsController < ApplicationController
  before_action :require_author!, only: [:edit, :update]

  def new
    @post = Post.new
    render :new
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user_id
    if @post.save
      redirect_to post_url(@post)
    else
      render :new
    end
  end

  def edit
    render :edit
  end

  def show
    @post = Post.find(params[:id])
    @all_comments = @post.comments_by_parent_id
    render :show
  end

  def update
    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      render :edit
    end
  end

  private

  def post_params
    params.require(:post).permit(
      :title, :url, :content, :author_id, sub_ids: []
    )
  end

  def require_author!
    @post = Post.find(params[:id])
    unless @post.author_id = current_user.id
      redirect_to sub_url(@post.sub)
    end
  end
end
