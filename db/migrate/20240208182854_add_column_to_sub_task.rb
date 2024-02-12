class AddColumnToSubTask < ActiveRecord::Migration[7.1]
  def change
    add_column :sub_tasks, :mark_as_complete, :boolean , default: false
  end
end
