class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.author_id = current_user_id
    if @comment.save
      redirect_to comment_url(@comment)
    else
      render :new
    end
  end

  def new
    @comment = Comment.new
    render :new
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to comment_url(@comment)
    else
      render :edit
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    render :edit
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.content = "[DELETED]"
    @comment.save
  end

  def show
    @comment = Comment.find(params[:id])
    @all_comments = @comment.post.comments_by_parent_id
    render :show
  end

  private
  def comment_params
    params.require(:comment).permit(:author_id, :post_id, :content, :parent_comment_id)
  end
end
