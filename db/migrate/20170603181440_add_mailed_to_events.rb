class AddMailedToEvents < ActiveRecord::Migration[5.0]
  def change
  	add_column :events, :mailed?, :boolean, default: false 
  end
end
