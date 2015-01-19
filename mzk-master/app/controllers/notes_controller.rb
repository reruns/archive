class NotesController < ApplicationController
  def create
    @note = Note.new
    @note.user_id = current_user.id
    @note.text = params[:note][:text]
    @note.track_id = params[:note][:track_id]
    @note.save
    redirect_to track_url(@note.track_id)
  end

  def destroy
    @note = Note.find(params[:note][:id])

    unless @note.user.id == current_user.id
      render status: :forbidden, text: "403 get out"
      return
    end

    track = @note.track_id
    @note.destroy
    redirect_to track_url(track)
  end
end
