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
					fb_event_id: event["id"],
					ticket_link: event["ticket_uri"]
				)
			end 
		end 
		send_event_mails
		redirect_to root_path, notice: "Event emails sent." 
	end 

	private 

	def check_if_user_has_email_setup
		redirect_to new_path if current_user.google_user.email.nil?
	end 

	def send_event_mails
		@current_user = current_user
		@google_user_email = current_user.google_user.email
		@current_user.events.where(mailed?: false).each do |event|
			email_address = @google_user_email
			email = gmail_user.compose do 
				to email_address
				subject "New FB Event: " + event.name 
				body "You have a new Facebook event: \n Event Name: " + event.name + ",\n Event Date: " + event.date + ",\n Event Location: " + event.location + ",\n Event Info: " + event.info 
			end 
			email.deliver!
			event.update(mailed?: true)
		end 
	end 
end
