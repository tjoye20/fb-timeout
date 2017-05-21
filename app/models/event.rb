class Event < ApplicationRecord
	belongs_to :facebook_users
	before_create :create_uuid 

	private 

	def create_uuid 
		begin
			self.uuid = SecureRandom.uuid 
		end while self.class.exits?(:uuid => uuid)
	end 
	
end
