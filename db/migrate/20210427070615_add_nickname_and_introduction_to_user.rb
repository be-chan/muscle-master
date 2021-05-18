class AddNicknameAndIntroductionToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :nickname, :string, null: false
    add_column :users, :introduction, :text
  end
end
