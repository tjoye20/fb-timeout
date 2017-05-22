class UpdateEventsTable < ActiveRecord::Migration[5.0]
  def change
  	add_column :events, :location, :text
  	add_column :events, :fb_event_id, :string 
  end
end
