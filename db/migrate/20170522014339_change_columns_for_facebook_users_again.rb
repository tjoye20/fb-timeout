class ChangeColumnsForFacebookUsersAgain < ActiveRecord::Migration[5.0]
  def change
  	remove_column :facebook_users, :username
  	remove_column :facebook_users, :token
  	remove_column :facebook_users, :secret


  	add_column :facebook_users, :username, :string 
  	add_column :facebook_users, :token, :text 
  	add_column :facebook_users, :secret, :text 
  end
end
