class EditTaskMigration < ActiveRecord::Migration
  def change
    change_table(:tasks) do |t|
      t.column :due_date, :timestamps
    end
  end
end
