class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.integer :user_id
      t.string :session_token

      t.timestamps null: false
    end

      add_index :sessions, :user_id
      add_index :sessions, :session_token, unique: true
      add_foreign_key :sessions, :users
      remove_column :users, :session_token
  end
end
