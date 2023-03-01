class Hackathons < ActiveRecord::Migration[6.1]
  def change
    create_table :hackathons do |t|
      t.string :image_url
      t.string :topic
      t.string :description
      t.string :location
      t.string :datetime
      t.timestamps 
    end
  end
end
