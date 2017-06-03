class EventsMailer < ApplicationMailer
	def new_events(name, email, event)
		@name = name 
		@email = email 
		@event = event 
		mail(to: @email, subject: "New FB Event:" + event.name)
	end 
end
