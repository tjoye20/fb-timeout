class EventsController < ApplicationController
	before_action :user_signed_in?
	
	def index 
		@events = current_user.events
	end 

	def create_events 
		fb_client.get_object("me/events/not_replied").each do |event|
			if !Event.find_by(event_id: event["id"]) && event["start_time"] > Time.now
				Event.create(
					name: event["name"],
					info: event["description"],
					date: event["start_time"],
					location: event["place"]["name"] + " " + event["place"]["location"]["street"] + " " + event["place"]["location"]["zip"],
					fb_event_id: event["id"]
				)
			end 
		end 
		redirect_to events_path 
	end 
end
