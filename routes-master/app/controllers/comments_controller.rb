class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      render json: @comment
    else
      render(json: @comment.errors.full_messages, status: :unprocessable_entity)
    end
  end

  def delete
    @comment = Comment.find(params[:id])
    Comment.delete(@comment)
    render json: @comment
  end

  private
  def comment_params
    params.require(:comment).permit(:text, :commentable_id, :commentable_type)

  end
end
