require 'rails_helper'

RSpec.describe 'メモ新規登録', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @memo = FactoryBot.build(:memo)
  end

  context 'メモ新規登録ができるとき' do
    it 'ログインしたユーザーはメモの登録できる' do
      visit new_user_session_path
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      find('input[name="commit"]').click
      expect(page).to have_selector '.add-training'
      visit new_memo_path
      select '2020', from: 'memo[start_time(1i)]'
      select '1月', from: 'memo[start_time(2i)]'
      select '1', from: 'memo[start_time(3i)]'
      fill_in 'memo_training_content', with: @memo.training_content
      fill_in 'memo_weight', with: @memo.weight
      fill_in 'memo_training_time', with: @memo.training_time
      select '1', from: 'memo[set_count_id]'
      expect do
        find('input[name="commit"]').click
      end.to change { Memo.count }.by(1)
      expect(current_path).to eq(memos_path)
      expect(page).to have_content('トレーニング内容を新しくメモしました')
      expect(page).to have_content('2020-01-01')
      expect(page).to have_content(@memo.training_content)
      expect(page).to have_content(@memo.weight)
      expect(page).to have_content(@memo.training_time)
      expect(page).to have_content('1')
    end
  end

  context 'メモ新規登録ができないとき' do
    it 'ログインしていないと新規メモ登録ページに遷移できない' do
      visit root_path
      expect(page).to have_no_selector '.add-training'
    end
  end
end

RSpec.describe 'メモ編集', type: :system do
  before do
    @memo1 = FactoryBot.create(:memo)
    @memo2 = FactoryBot.create(:memo)
  end
  context 'メモ編集ができるとき' do
    it 'ログインしたユーザーは自分が投稿したメモの編集ができる' do
      visit new_user_session_path
      fill_in 'user_email', with: @memo1.user.email
      fill_in 'user_password', with: @memo1.user.password
      find('input[name="commit"]').click
      expect(page).to have_link href: edit_memo_path(@memo1)
      visit edit_memo_path(@memo1)
      expect(
        find('#memo_start_time_1i').value
      ).to eq(@memo1.start_time.year.to_s)
      expect(
        find('#memo_start_time_2i').value
      ).to eq(@memo1.start_time.month.to_s)
      expect(
        find('#memo_start_time_3i').value
      ).to eq(@memo1.start_time.day.to_s)
      expect(
        find('#memo_training_content').value
      ).to eq(@memo1.training_content)
      expect(
        find('#memo_weight').value
      ).to eq(@memo1.weight.to_s)
      expect(
        find('#memo_training_time').value
      ).to eq(@memo1.training_time.to_s)
      expect(
        find('#traning-set-count').value
      ).to eq(@memo1.set_count.name)
      select '2019', from: 'memo[start_time(1i)]'
      select '2月', from: 'memo[start_time(2i)]'
      select '2', from: 'memo[start_time(3i)]'
      fill_in 'memo_training_content', with: @memo1.training_content + '編集'
      fill_in 'memo_weight', with: @memo1.weight + 1
      fill_in 'memo_training_time', with: @memo1.training_time + 1
      select '2', from: 'memo[set_count_id]'
      expect do
        find('input[name="commit"]').click
      end.to change { Memo.count }.by(0)
      expect(page).to have_content('トレーニング内容を更新しました')
      expect(page).to have_content('2019-02-02')
      expect(page).to have_content(@memo1.training_content + '編集')
      expect(page).to have_content(@memo1.weight + 1)
      expect(page).to have_content(@memo1.training_time + 1)
      expect(page).to have_content('2')
    end
  end
  context 'メモ編集ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿したメモの編集画面には遷移できない' do
      visit new_user_session_path
      fill_in 'user_email', with: @memo1.user.email
      fill_in 'user_password', with: @memo1.user.password
      find('input[name="commit"]').click
      expect(page).to have_no_link href: edit_memo_path(@memo2)
    end
    it 'ログインしていないとメモの編集画面には遷移できない' do
      visit root_path
      expect(page).to have_no_link href: edit_memo_path(@memo1)
      expect(page).to have_no_link href: edit_memo_path(@memo2)
    end
  end
end

RSpec.describe 'メモ削除', type: :system do
  before do
    @memo1 = FactoryBot.create(:memo)
    @memo2 = FactoryBot.create(:memo)
  end
  context 'メモ削除ができるとき' do
    it 'ログインしたユーザーは自らが投稿したメモの削除ができる' do
      visit new_user_session_path
      fill_in 'user_email', with: @memo1.user.email
      fill_in 'user_password', with: @memo1.user.password
      find('input[name="commit"]').click
      expect(page).to have_link href: memo_path(@memo1)
      expect do
        find_link(href: memo_path(@memo1)).click
        expect(page.accept_confirm).to eq '本当に削除しマッスルか？'
        expect(page).to have_content('トレーニング内容を削除しました')
      end.to change { Memo.count }.by(-1)
      expect(page).to have_no_content(@memo1)
    end
  end
  context 'メモ削除ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿したメモの削除ができない' do
      visit new_user_session_path
      fill_in 'user_email', with: @memo1.user.email
      fill_in 'user_password', with: @memo1.user.password
      find('input[name="commit"]').click
      expect(page).to have_no_link href: memo_path(@memo2)
    end
    it 'ログインしていないとメモの削除ボタンがない' do
      root_path
      expect(page).to have_no_link href: memo_path(@memo1)
      expect(page).to have_no_link href: memo_path(@memo2)
    end
  end
end
