class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.text :token, null: false
      t.text :secret, null: false

      t.timestamps(null: false)
    end
  end
end
