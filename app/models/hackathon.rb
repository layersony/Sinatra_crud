class Hackathon < ActiveRecord::Base
  has_many :events
  has_many :users, through: :events
end