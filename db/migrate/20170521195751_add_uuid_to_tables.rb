class AddUuidToTables < ActiveRecord::Migration[5.0]
  def change
  	add_column :events, :uuid, :string 
  	add_column :facebook_users, :uuid, :string 
  	add_column :google_users, :uuid, :string 
  end
end
