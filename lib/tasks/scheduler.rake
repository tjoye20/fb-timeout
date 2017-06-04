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
					fb_event_id: event["id"]
				)
			end 
	 	end 
		 user.events.where(mailed?: false).each do |event|
			EventsMailer.new_events(user.username, user.email, event).deliver_now
		 end 
	end 
end