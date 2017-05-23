class AddRefreshTokenToGoogleUsers < ActiveRecord::Migration[5.0]
  def change
  	add_column :google_users, :refresh_token, :string 
  end
end
