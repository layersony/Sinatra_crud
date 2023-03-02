class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'
  
  # Add your routes here
  get "/" do
    hackathons = Hackathon.all # get all hackathons (array format)
    hackathons.to_json()
  end

  # Get Single Hackathon
  get "/hackathon/:id" do 
    hackathon = Hackathon.find_by(id: params[:id])
    hackathon.to_json()
  end

  # Post Hackathon
  post "/hackathon/" do
    hackathon = Hackathon.create(
      image_url: params[:image_url],
      topic: params[:topic],
      description: params[:description],
      location: params[:location],
      datetime: params[:datetime]
    )
    hackathon.save()

    {
      "Message": "Created successfully",
      "Status": "HTTP_200_OK"
    }.to_json()
  end

  # Patch Hackathon
  patch "/hackathon/update/:id" do 
    hackathon = Hackathon.find_by(id: params[:id])

    hackathon.update(
      image_url: params[:image_url],
      topic: params[:topic],
      description: params[:description],
      location: params[:location],
      datetime: params[:datetime]
    )

    hackathon.to_json()
  end

  # Delete a Hackathon
  delete "/hackathon/:id" do 
    hackathon = Hackathon.find_by(id: params[:id])
    hackathon.destroy
    {
      "message":"Successfully Delete Hackathon #{params[:id]}",
      "Status":"HTTP_Status_OK"
    }.to_json()
  end

  # Save User
  post "/user/" do
    existing_user = User.find_by(email: params[:email])
    # check if user exists
    if existing_user
      return {"error":"User Already Existing"}.to_json()
    end
    # create user instance
    user = User.create(
      fullname: params[:fullname],
      email: params[:email],
      phonenumber: params[:phonenumber],
      language: params[:language],
      roles: params[:roles],
    )
    user.save
    {
      "message":"User Created Successfully",
      "status": "HTTP_201_created",
    }.to_json()
  end

  # register event
  post "/book/event/" do 
    # get hackathon_id from either postman or frontend(React/Angular)
    hackathon = Hackathon.find_by(id: params[:hackathon_id])
    # get user email from postman so to get the users id
    existing_user = User.find_by(email: params[:email])

    # create event instance
    if existing_user
      event = Event.create(
        user_id: existing_user.id,
        hackathon_id: hackathon.id
      )
      event.save
      {
        "message":"Event Created Successfully for user #{existing_user.fullname}",
        "status":"201_Created"
      }.to_json()
    else
      {
        "error":"User not found",
        "status":"404_not_found"
      }.to_json()
    end

  end

  # Get all hackathon users
  get '/hackathon/:id/users' do
    # get the hackathon
    hackathon = Hackathon.find_by(id: params[:id])
    hackathon.events.find_all do |event|
      event.user_id
    end.to_json(only: [:id], include: {user: {only: [:id, :fullname, :email, :phonenumber, :language, :roles]}})
  end

end

