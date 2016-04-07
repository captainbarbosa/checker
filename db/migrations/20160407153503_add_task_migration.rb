class AddTaskMigration < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.timestamps null: true
      t.string :email
    end
  end
end
