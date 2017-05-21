class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
    	t.belongs_to :facebook_user
    	t.string :name 
    	t.text :info 
    	t.string :date 

      t.timestamps
    end
  end
end
