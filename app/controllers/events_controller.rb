class EventsController < ApplicationController
	before_action :user_signed_in?
	before_action :check_if_user_has_email_setup

	def index 
		@events = current_user.events
	end 

	def show 
		@event = current_user.events.find_by(uuid: params[:id])
	end 

	def create_events 
		fb_client.get_object("me/events/not_replied").each do |event|
			if !current_user.events.find_by(fb_event_id: event["id"]) && event["start_time"] > Time.now
				current_user.events.create(
					name: event["name"],
					info: event["description"],
					date: event["start_time"].to_date,
					location: event["place"]["name"] + " " + event["place"]["location"]["street"] + " " + event["place"]["location"]["zip"],
					fb_event_id: event["id"]
				)
			end 
		end 
		send_event_mails
		redirect_to events_path 
	end 
end

private 

def check_if_user_has_email_setup
	redirect_to new_path if current_user.email.nil?
end 

def send_event_mails
	current_user.events.where(mailed?: false).each do |event|
		EventsMailer.new_events(current_user.username, current_user.email, event).deliver_now
	end 
end 