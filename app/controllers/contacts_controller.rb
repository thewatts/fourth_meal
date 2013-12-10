class ContactsController < ApplicationController

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      success_message
    else
      failure_message
    end
    redirect_to root_path
  end

  def new
    @contact = Contact.new
  end

  private

  def success_message
    flash[:notice] = "Thanks for your message! 
    We'll get back to you as soon as possible."
  end

  def failure_message
    flash[:notice] = "There were problems with your message: #{@contact.errors.full_messages}.
    We'd love to hear from you, so please try again!"
  end

  def contact_params
    params.require(:contact).permit(:name, :email, :subject, :comment)
  end
end
