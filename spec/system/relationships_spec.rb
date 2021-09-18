require 'rails_helper'

RSpec.describe 'Relationships', type: :system do
  before do
    @user1 = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)
    @relationship = FactoryBot.create(:relationship, follower_id: @user1.id, following_id: @user2.id)
  end

  context 'フォローとフォロー解除ができるとき', js: true do
    it 'ユーザーをフォロー、フォロー解除できる' do
      visit new_user_session_path
      fill_in 'user_email', with: @user2.email
      fill_in 'user_password', with: @user2.password
      find('input[name="commit"]').click
      visit user_path(@user1)
      expect do
        find('input[name="commit"]').click
        sleep 0.1
      end.to change { Relationship.count }.by(1)
      expect(current_path).to eq user_path(@user1)
      expect do
        find('input[name="commit"]').click
        sleep 0.1
      end.to change { Relationship.count }.by(-1)
      expect(current_path).to eq user_path(@user1)
    end
  end
end
