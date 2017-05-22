class EventsController < ApplicationController

	def create 
		fb_client.get_object("me/events/not_replied").each do |event|
			if event["start_time"] > Time.now && !Event.find_by(event_id: event["id"])
				Event.create(
					name: event["name"],
					info: event["description"],
					date: event["start_time"],
					location: event["place"]["name"] + " " + event["place"]["location"]["street"] + " " + event["place"]["location"]["zip"],
					fb_event_id: event["id"]
				)
			end 
		end 


	end 
end
