puts "🌱 Seeding spices..."

# Seed your database here

# create hackathon instance
h1 = Hackathon.create(
  image_url: "https://bit.ly/3SHMOQs",
  topic: "Sinatra Hackathon",
  description: "Sinatra Application for All",
  location: "Nairobi, Ngong Lane",
  datetime: "02/03/2022 12:00:00" # DD/MM/YYYY HH:MM:SS
)

# create user instance
u1 = User.create(
  fullname: "John Doe",
  email: "john@example.com",
  phonenumber: "0723456789",
  language: "Javascript, Python, Ruby, C++",
  roles: "Backend Developer"
)

# create event instance
e1 = Event.create(
  user_id: u1.id,
  hackathon_id: h1.id
)

puts "✅ Done seeding!"
