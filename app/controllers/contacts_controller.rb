class ContactsController < ApplicationController
    def new
        
        @contact =Contact.new
        
    end
    
    def create
        
        @contact =Contact.new(contact_params)
        
        if @contact.save
            
            name=params[:contact][:name]
            email=params[:contact][:email]
            body=params[:contact][:body]
            
            ContactMailer.contact_email(name, email, body).deliver
            
            flash[:success] = "Message sent"
           render 'contacts/new'
        else
            flash[:danger] = "Error occured, mesage has not been sent."
             render 'contacts/new'
        end
    end
    
    private
    
        def contact_params
            
            params.require(:contact).permit(:name, :email, :comments)
        end

end    