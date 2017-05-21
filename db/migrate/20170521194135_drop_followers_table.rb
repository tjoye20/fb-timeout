class DropFollowersTable < ActiveRecord::Migration[5.0]
  def change
  	drop_table :followers 
  	drop_table :phrases 
  end
end
