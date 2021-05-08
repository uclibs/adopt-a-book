# ContactController manages contact us page
class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(params[:contact])
    if @contact.deliver
      ContactMailer.contact_form(@contact).deliver
    else
      flash.now[:error] = 'cannot send message'
      render :new
    end
  end
end
