class AddEmailAndPictureToUsersAndCreateGoogleTable < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :email, :string 
  	add_column :users, :picture, :string 
  	rename_table :users, :facebook_users

  	create_table :google_users do |t|
  		t.string :username
  		t.string :email 
  		t.string :picture 
  		t.text :token
  		t.text :secret

  		t.timestamps(null: false)
  	end 
  end
end
