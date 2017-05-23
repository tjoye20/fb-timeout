class FacebookUser < ApplicationRecord
  # has_one :google_user, dependent: :destroy 
  has_many :events, dependent: :destroy 
  before_create :create_uuid

  private 

  def create_uuid 
    begin
      self.uuid = SecureRandom.uuid 
    end while self.class.exists?(:uuid => uuid)
  end

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
