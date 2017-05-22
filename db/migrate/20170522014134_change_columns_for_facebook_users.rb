class ChangeColumnsForFacebookUsers < ActiveRecord::Migration[5.0]
  def change
  	change_column :facebook_users, :username, :string 
  	change_column :facebook_users, :token, :text 
  	change_column :facebook_users, :secret, :text 

  end
end
