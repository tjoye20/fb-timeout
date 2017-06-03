class EventsMailer < ApplicationMailer
	def new_events(name, email, event)
		@name = name 
		@email = email 
		@event = event 
		@event.update(mailed?: true)
		mail(to: @email, subject: "New FB Event:" + event.name)
	end 
end
