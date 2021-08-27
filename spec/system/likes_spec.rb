require 'rails_helper'

RSpec.describe "いいねをする", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @tweet = FactoryBot.create(:tweet)
    @like = FactoryBot.build(:like, tweet_id: @tweet.id)
  end

  context 'いいねができるとき' do
    it 'ログインしているユーザーはいいねができる' do
      visit new_user_session_path
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(memos_path)
      visit tweets_path
      expect(page).to have_link href: tweet_likes_path(@like.tweet.id)
      expect{
        find_link(href: tweet_likes_path(@like.tweet.id)).click
        sleep 0.1
      }.to change { Like.count }.by(1)
      expect(current_path).to eq(tweets_path)
      expect(page).to have_no_link href: tweet_likes_path(@like.tweet.id)
    end
  end
  context 'いいねができないとき' do
    it 'ログインしていない場合はいいねボタンがない' do
      visit root_path
      expect(page).to have_no_link href: tweet_likes_path(@like.tweet.id)
    end
  end
end

RSpec.describe "いいねを解除(削除)する", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @tweet = FactoryBot.create(:tweet)
    @like = FactoryBot.create(:like, tweet_id: @tweet.id, user_id: @user.id)
  end

  context 'いいねが解除(削除)できるとき' do
    it 'ログインしているユーザーは元々いいねしてたメモシェア投稿のいいねを解除することができる' do
      visit new_user_session_path
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(memos_path)
      visit tweets_path
      expect(page).to have_link href: tweet_like_path(@like.tweet.id, @like.id)
      expect{
        find_link(href: tweet_like_path(@like.tweet.id,@like.id)).click
        sleep 0.1
      }.to change { Like.count }.by(-1)
      expect(current_path).to eq tweets_path
      expect(page).to have_no_link tweet_like_path(@like.tweet.id, @like.id)
    end
  end
  context 'いいねが解除ができないとき' do
    it 'ログインしていない場合はいいねボタンがない' do
      visit root_path
      expect(page).to have_no_link href: tweet_like_path(@like.tweet.id, @like.id)
    end
  end
end
