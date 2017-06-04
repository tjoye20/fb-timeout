class AddTicketLinkToEvents < ActiveRecord::Migration[5.0]
  def change
  	add_column :events, :ticket_link, :text 
  end
end
