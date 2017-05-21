class FacebookUser < ApplicationRecord
  has_one :google_user, dependent: :destroy 

  protected

  def self.create_user(auth_hash)
    self.create(
      username: auth_hash.info.name,
      email: auth_hash.info.email,
      picture: auth_hash.info.image,
      token: auth_hash.credentials.token
    )
  end 

end
