class GoogleUser < ApplicationRecord
  belongs_to :facebook_users 

  protected

  def self.create(auth_hash, fb_user_id)
    self.create_user(
      username: auth_hash.info.name,
      email: auth_hash.info.email,
      picture: auth_hash.info.image,
      token: auth_hash.credentials.token,
      facebook_user_id: fb_user_id
    )
  end 

end
