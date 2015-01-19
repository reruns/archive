class TracksController < ApplicationController
  before_action :require_user!
  
  def new
    @track = Track.new
    render :new
  end

  def create
    @track = Track.new(track_params)
    if @track.save
      redirect_to track_url(@track)
    else
      flash.now[:errors] = @track.errors.full_messages
      render :new
    end
  end

  def edit
    @track = Track.find(params[:id])
    render :edit
  end

  def update
    @track = Track.new(track_params)
    if @track.update
      redirect_to track_url(@track)
    else
      flash.now[:errors] = @track.errors.full_messages
      render :edit
    end
  end

  def show
    @track = Track.find(params[:id])
    render :show
  end

  private

  def track_params
    params.require(:track).permit(:title, :album_id, :kind, :lyrics)
  end

end
