class RenameSetCountColumnToMemos < ActiveRecord::Migration[6.0]
  def change
    rename_column :memos, :set_count, :set_count_id
  end
end
