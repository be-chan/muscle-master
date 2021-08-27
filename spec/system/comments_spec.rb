require 'rails_helper'

RSpec.describe 'コメント投稿', type: :system do
  before do
    @tweet = FactoryBot.create(:tweet)
    @comment = FactoryBot.build(:comment)
  end

  it 'ログインしたユーザーはツイート詳細ページでコメント投稿できる' do
    visit new_user_session_path
    visit new_user_session_path
    fill_in 'user_email', with: @tweet.user.email
    fill_in 'user_password', with: @tweet.user.password
    find('input[name="commit"]').click
    expect(current_path).to eq(memos_path)
    visit tweets_path
    visit tweet_path(@tweet)
    fill_in 'comment_body', with: @comment
    expect{
      find('#comment_body').send_keys :return
    }.to change { Comment.count }.by(1)
    expect(current_path).to eq tweet_path(@tweet)
    expect(page).to have_content @comment
  end
end

