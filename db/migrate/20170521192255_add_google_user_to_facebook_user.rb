class AddGoogleUserToFacebookUser < ActiveRecord::Migration[5.0]
  def change
    add_reference :google_users, :facebook_user, foreign_key: true
  end
end
