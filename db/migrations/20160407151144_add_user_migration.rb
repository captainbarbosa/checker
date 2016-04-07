class AddUserMigration < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.timestamps null: true
      t.integer :user_id
      t.text :task
      t.boolean :completed
    end
  end
end
