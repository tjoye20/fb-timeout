desc "This task is called by the Heroku scheduler add-on"
task :check_for_new_events => :environment do
	FacebookUser.all.each do |user| 
		fb_client = Koala::Facebook::API.new(user.token)
		fb_client.get_object("me/events/not_replied").each do |event|
			if !user.events.find_by(fb_event_id: event["id"]) && event["start_time"] > Time.now
				user.events.create(
					name: event["name"],
					info: event["description"],
					date: event["start_time"].to_date,
					location: event["place"]["name"] + " " + event["place"]["location"]["street"] + " " + event["place"]["location"]["zip"],
					fb_event_id: event["id"],
					ticket_link: event["ticket_uri"]
				)
			end 
	 	end 
		gmail_user = Gmail.connect(:xoauth2, user.google_user.email, user.google_user.token)
		user_email = user.email 
		user.events.where(mailed?: false).each do |event|
		 	email_address = user_email
			email = gmail_user.compose do 
				to email_address
				subject "New FB Event: " + event.name 
				body "You have a new Facebook event: \n Event Name: " + event.name + ",\n Event Date: " + event.date + ",\n Event Location: " + event.location + ",\n Event Info: " + event.info 
			end 
			begin 
				email.deliver!
				event.update(mailed?: true)
			rescue
				5.times do puts "Email delivery failed! gmail_user may have disconnected." end 
			end 
		end 
	end 
end