class CreateMemos < ActiveRecord::Migration[6.0]
  def change
    create_table :memos do |t|
      t.datetime :start_time,     null: false
      t.string :training_content, null: false
      t.integer :weight,          null: false
      t.integer :training_time,   null: false
      t.integer :set_count,       null: false
      t.references :user,         foreign_key: true
      t.timestamps
    end
  end
end
