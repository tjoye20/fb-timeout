class Event < ApplicationRecord
	belongs_to :facebook_user
	before_create :create_uuid 

	private 

	def create_uuid 
		begin
			self.uuid = SecureRandom.uuid 
		end while self.class.exists?(:uuid => uuid)
	end 
	
end
