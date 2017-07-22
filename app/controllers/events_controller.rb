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
end

private 

def check_if_user_has_email_setup
	redirect_to new_path if current_user.email.nil?
end 

def send_event_mails
	current_user.events.where(mailed?: false).each do |event|
		gmail_user.deliver do 
			to current_user.google_user.email
			subject "New FB Event: " + event.name 
			text_part do 
				body "You have a new Facebook event: \n Event Name: " + event.name + ",\n Event Date: " + event.date + ",\n Event Location: " + event.location + ",\n Event Info: " + event.info + ",\n Event Tickets: " + event.ticket_link
			end  
			html_part do 
				content_type 'text/html; charset=UTF-8'
				body "<p>
      You have a new Facebook event: <br>
      Event Name: " + event.name + ",
      Event Date: " + event.date + ",
      Event Location: " + event.location + ",
      Get Tickets: " + event.ticket_link + ", <br>
      Event Info: " + event.info + "
    </p><br>
    <p>Have a nice day!</p>"

			end  
		end 
	end 
end 