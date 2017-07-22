class GoogleUser < ApplicationRecord
  belongs_to :facebook_user 
  before_create :create_uuid

  private 

  def create_uuid 
    begin
      self.uuid = SecureRandom.uuid 
    end while self.class.exists?(:uuid => uuid)
  end 

  protected

  def self.create_user(auth_hash, fb_user_id)
    self.create(
      username: auth_hash.info.name,
      email: auth_hash.info.email,
      picture: auth_hash.info.image,
      token: auth_hash.credentials.token,
      refresh_token: auth_hash.credentials.refresh_token,
      facebook_user_id: fb_user_id
    )
  end 

end
