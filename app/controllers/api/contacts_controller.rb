class Api::ContactsController < ApplicationController

  def index
    @contacts = Contact.all
    
    if params[:search]
      @contacts = @contacts.where("first_name iLIKE ? OR middle_name iLIKE ? OR last_name iLIKE ? OR email iLIKE ? OR phone_number iLIKE ? OR bio iLIKE ?", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%")
    end

    # if params[:first_name]
    #   @contacts = @contacts.where("first_name iLIKE ?", "%#{params[:first_name]}%")
    # end

    # if params[:middle_name]
    #   @contacts = @contacts.where("middle_name iLIKE ?", "%#{params[:middle_name]}%")
    # end

    # if params[:last_name]
    #   @contacts = @contacts.where("last_name iLIKE ?", "%#{params[:last_name]}%")
    # end

    # if params[:email]
    #   @contacts = @contacts.where("email iLIKE ?", "%#{params[:email]}%")
    # end

    # if params[:phone_number]
    #   @contacts = @contacts.where("phone_number iLIKE ?", "%#{params[:phone_number]}%")
    # end
    # if params[:bio]
    #   @contacts = @contacts.where("bio iLIKE ?", "%#{params[:bio]}%")
    # end

    render "index.json.jb"
  end

  def show
    @contact = Contact.find_by(id: params[:id])
    render "show.json.jb"
  end
  
  def create
    @contact = Contact.new(
      first_name: params[:first_name],
      middle_name: params[:middle_name],
      last_name: params[:last_name],
      email: params[:email],
      phone_number: params[:phone_number],
      latitude: params[:latitude],
      longitude: params[:longitude],
      bio: params[:bio]
    )
    if @contact.save # happy path
      render "show.json.jb"
    else # sad path
      render json: {error: @contact.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def update
    @contact = Contact.find_by(id: params[:id])
    @contact.first_name = params[:first_name] || @contact.first_name
    @contact.middle_name = params[:middle_name] || @contact.middle_name
    @contact.last_name = params[:last_name] || @contact.last_name
    @contact.email = params[:email] || @contact.email
    @contact.phone_number = params[:phone_number] || @contact.phone_number
    @contact.latitude = params[:latitude] || @contact.latitude
    @contact.longitude = params[:longitude] || @contact.longitude
    @contact.bio = params[:bio] || @contact.bio
    if @contact.save # happy path
      render "show.json.jb"
    else # sad path
      render json: {error: @contact.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def destroy
    contact = Contact.find_by(id: params[:id])
    contact.destroy
    render json: {message: "Bye bye, contact!!"}
  end

end
