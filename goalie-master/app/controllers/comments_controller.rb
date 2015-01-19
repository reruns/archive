class CommentsController < ApplicationController

  def create
    @owner = params[:id_type].constantize.find(params[:owner_id])
    @comment = @owner.comments.new(comment_params)
    @comment.author_id = current_user.id
    if @comment.save
      redirect_to(:back)
    else
      flash[:errors] = ["Comment cannot be blank!"]
      redirect_to(:back)
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:comment)
  end
end
