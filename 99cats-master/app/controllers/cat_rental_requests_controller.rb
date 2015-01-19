class CatRentalRequestsController < ApplicationController
  before_action :set_cat, only: [:approve, :deny]
  before_action :check_cat_ownership, only: [:approve, :deny]

  def new
    @crr = CatRentalRequest.new
    render :new
  end

  def create
    redirect_to new_session_url unless signed_in?
    @crr = CatRentalRequest.new(crr_params)
    @crr.user_id = current_user.id
    if @crr.save
      redirect_to cat_url(@crr.cat_id)
    else
      flash.now[:errors] = @crr.errors.full_messages
      render :new
    end
  end

  def approve
    @crr.approve!
    redirect_to cat_url(@crr.cat_id)
  end

  def deny
    @crr.deny!
    redirect_to cat_url(@crr.cat_id)
  end

  private
  def set_cat
    @crr = CatRentalRequest.find(params[:id])
    @cat = Cat.find(@crr.cat_id)
  end

  def crr_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date)
  end
end
