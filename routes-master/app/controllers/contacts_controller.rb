class ContactsController < ApplicationController

  def index
    @user = User.find(params[:id])
    render json: (@user.contacts + @user.shared_contacts)
  end

  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      render json: @contact
    else
      render(json: @contact.errors.full_messages, status: :unprocessable_entity)
    end
  end

  def show
    render json: = Contact.find(params[:id])
  end

  def update
    @contact = Contact.find(params[:id])

    if @contact.update(contact_params)
      render json: @contact
    else
      render(json: @contact.errors.full_messages, status: :unprocessable_entity)
    end
  end

  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy
    render json: @contact
  end

  def comments
    @contact = Contact.find(params[:id])
    render json: @contact.comments
  end

  private
  def contact_params
    params.require(:contact).permit(:email, :name, :user_id, :favorite)
  end

end
