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

end

