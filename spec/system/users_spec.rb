require 'rails_helper'

RSpec.describe 'ユーザー登録', type: :system do
  before do
    @user = FactoryBot.build(:user)
  end
  context 'ユーザー登録ができるとき' do
    it '正しい情報を入力すればユーザー新規登録ができてメモ一覧ページへ移動する' do
      visit root_path
      expect(page).to have_content('アカウントを作成する')
      visit new_user_registration_path
      fill_in 'user_nickname', with: @user.nickname
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      fill_in 'user_password_confirmation', with: @user.password_confirmation
      fill_in 'introduce_text', with: @user.introduction
      expect  do
        find('input[name="commit"]').click
      end.to change { User.count }.by(1)
      expect(current_path).to eq(memos_path)
      expect(page).to have_content('ログアウト')
      expect(page).to have_no_content('サインアップ')
      expect(page).to have_no_content('ログイン')
    end
  end
  context 'ユーザー登録ができないとき' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      visit root_path
      expect(page).to have_content('アカウントを作成する')
      visit new_user_registration_path
      fill_in 'user_nickname', with: ''
      fill_in 'user_email', with: ''
      fill_in 'user_password', with: ''
      fill_in 'user_password_confirmation', with: ''
      fill_in 'introduce_text', with: ''
      expect  do
        find('input[name="commit"]').click
      end.to change { User.count }.by(0)
      expect(current_path).to eq user_registration_path
    end
  end
end
RSpec.describe 'ログイン', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  context 'ログインができるとき' do
    it '保存されているユーザーの情報と合致すればログインができる' do
      visit root_path
      expect(page).to have_content('ログイン')
      visit new_user_session_path
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(memos_path)
      expect(page).to have_content('ログアウト')
      expect(page).to have_no_content('サインアップ')
      expect('.nav-link').to have_no_content('ログイン')
    end
  end
  context 'ログインができないとき' do
    it '保存されているユーザーの情報と合致しないとログインができない' do
      visit root_path
      expect(page).to have_content('ログイン')
      visit new_user_session_path
      fill_in 'user_email', with: ''
      fill_in 'user_password', with: ''
      find('input[name="commit"]').click
      expect(current_path).to eq(new_user_session_path)
    end
  end
end

RSpec.describe 'ユーザー編集', type: :system do
  before do
    @user1 = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)
  end
  context 'ユーザーを編集できるとき' do
    it 'ユーザー自身のユーザー情報は編集ができる' do
      visit new_user_session_path
      fill_in 'user_email', with: @user1.email
      fill_in 'user_password', with: @user1.password
      find('input[name="commit"]').click
      visit user_path(@user1)
      expect(page).to have_link href: edit_user_registration_path
      visit edit_user_registration_path
      expect(
        find('#user_nickname').value
      ).to eq(@user1.nickname)
      expect(
        find('#user_email').value
      ).to eq(@user1.email)
      expect(
        find('#introduce_text').value
      ).to eq(@user1.introduction)
      attach_file 'profile_image_upload', "#{Rails.root}/public/images/test2_image.jpeg"
      fill_in 'user_nickname', with: "#{@user1.nickname}編集マン"
      fill_in 'user_email', with: "edit#{@user1.email}"
      fill_in 'introduce_text', with: "#{@user1.introduction}編集しました"
      expect  do
        find('input[name="commit"]').click
      end.to change { User.count }.by(0)
      expect(current_path).to eq user_path(@user1)
      expect(page).to have_content('アカウント情報を変更しました')
      expect(page).to have_content "#{@user1.nickname}編集マン"
      expect(page).to have_content "#{@user1.introduction}編集しました"
    end
  end
  context 'ユーザーを編集できないとき' do
    it 'ログイン中のユーザー他のユーザー詳細ページで編集ボタンがない' do
      visit new_user_session_path
      fill_in 'user_email', with: @user1.email
      fill_in 'user_password', with: @user1.password
      find('input[name="commit"]').click
      visit user_path(@user2)
      expect(page).to have_no_link href: edit_user_registration_path
    end
    it 'ログインしていないとユーザーの編集ボタンがない' do
      visit root_path
      expect(page).to have_no_link href: edit_user_registration_path
    end
  end
end

RSpec.describe 'ユーザー削除', type: :system do
  before do
    @user1 = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)
  end
  context 'ユーザー削除ができるとき', js: true do
    it 'ログインしたユーザーは自身のユーザー情報を削除できる(退会)' do
      visit new_user_session_path
      fill_in 'user_email', with: @user1.email
      fill_in 'user_password', with: @user1.password
      find('input[name="commit"]').click
      visit user_path(@user1)
      expect(page).to have_link href: user_registration_path
      expect do
        find_link(href: user_registration_path).click
        expect(page.accept_confirm).to eq '本当に退会しますか？'
        expect(current_path).to eq root_path
      end.to change { User.count }.by(-1)
    end
  end
  context 'ユーザー削除ができないとき' do
    it 'ログインしたユーザーは他のユーザー詳細ページで削除ボタンがない' do
      visit new_user_session_path
      fill_in 'user_email', with: @user1.email
      fill_in 'user_password', with: @user1.password
      find('input[name="commit"]').click
      visit user_path(@user2)
      expect(page).to have_no_link href: user_registration_path
    end
    it 'ログインしていないとユーザーの削除ボタンがない' do
      visit root_path
      expect(page).to have_no_link href: user_registration_path
    end
  end
end
