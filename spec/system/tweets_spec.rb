require 'rails_helper' 

RSpec.describe "メモシェア機能", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @memo = FactoryBot.create(:memo, id: 1)
    @tweet = FactoryBot.build(:tweet, memo_id: @memo.id )
  end

  context 'メモシェアができるとき'do
    it 'ログインしたユーザーは新規投稿できる' do
      visit new_user_session_path
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      find('input[name="commit"]').click
      visit new_memo_path
      select '2020', from: 'memo[start_time(1i)]'
      select '1月', from: 'memo[start_time(2i)]'
      select '1', from: 'memo[start_time(3i)]'
      fill_in 'memo_training_content', with: @memo.training_content
      fill_in 'memo_weight', with: @memo.weight
      fill_in 'memo_training_time', with: @memo.training_time
      select '1', from: 'memo[set_count_id]'
      expect{
        find('input[name="commit"]').click
      }.to change { Memo.count }.by(1)
      expect(page).to have_selector('.fa-share-square')
      visit new_memo_tweet_path(@memo)
      fill_in 'introduce_text', with: @tweet.body
      expect{
        find('input[name="commit"]').click
      }.to change { Tweet.count }.by(1)
      expect(current_path).to eq(tweets_path)
      expect(page).to have_content('投稿が完了しました')
      expect(page).to have_content(@tweet.body)
    end
  end

  context 'メモシェアができないとき'do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      visit root_path
      expect(page).to have_no_selector('.fa-share-square')
    end

    it 'メモがないと新規投稿ページに遷移できない' do
       visit new_user_session_path
       fill_in 'user_email', with: @user.email
       fill_in 'user_password', with: @user.password
       find('input[name="commit"]').click
       expect(page).to have_no_selector('.fa-share-square')
    end
  end
end

RSpec.describe 'メモシェア削除', type: :system do
  before do
    @tweet1 = FactoryBot.create(:tweet)
    @tweet2 = FactoryBot.create(:tweet)
  end
  context 'メモシェア削除ができるとき' do
    it 'ログインしたユーザーは自らが投稿したメモシェアの削除ができる' do
      visit new_user_session_path
      fill_in 'user_email', with: @tweet1.user.email
      fill_in 'user_password', with: @tweet1.user.password
      find('input[name="commit"]').click
      visit tweets_path
      expect(
        all('.tweet-time')[1]
      ).to have_link href: memo_tweet_path(@tweet1.memo, @tweet1.id)
      expect{
        all('.tweet-time')[1].find_link(href: memo_tweet_path(@tweet1.memo, @tweet1.id)).click
        expect(page.accept_confirm).to eq "本当に削除しマッスルか？"
        expect(current_path).to eq(tweets_path)
        expect(page).to have_content('削除が完了しました')
      }.to change{ Tweet.count }.by(-1)   
      expect(page).to have_no_content("#{@tweet1.body}")
    end
  end
  context 'メモシェア削除ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿したメモシェアの削除ができない' do
      visit new_user_session_path
      fill_in 'user_email', with: @tweet1.user.email
      fill_in 'user_password', with: @tweet1.user.password
      find('input[name="commit"]').click
      visit tweets_path
      expect(
        all('.tweet-time')[0]
      ).to have_no_link href: memo_tweet_path(@tweet2.memo, @tweet2.id)
    end
    it 'ログインしていないとメモシェアの削除ボタンがない' do
      visit root_path
      expect(
        all('.tweet-time')[1]
      ).to have_no_link href: memo_tweet_path(@tweet1.memo, @tweet1.id)
      expect(
        all('.tweet-time')[0]
      ).to have_no_link href: memo_tweet_path(@tweet2.memo, @tweet2.id)
    end
  end
end

RSpec.describe 'メモシェア詳細', type: :system do
  before do
    @tweet = FactoryBot.create(:tweet)
  end
  it 'ログインしたユーザーはメモシェア詳細ページに遷移してコメント投稿欄が表示される' do
    visit new_user_session_path
    fill_in 'user_email', with: @tweet.user.email
    fill_in 'user_password', with: @tweet.user.password
    find('input[name="commit"]').click
    visit tweets_path
    expect(
      all(".row")[0]
    ).to have_link href: tweet_path(@tweet)
    visit tweet_path(@tweet)
    expect(page).to have_content("#{@tweet.body}")
    expect(page).to have_selector 'form'
  end
  it 'ログインしていない状態でメモシェア詳細ページのボタンがない' do
    visit root_path
    expect(
      all(".row")[0]
    ).to have_no_link href: tweet_path(@tweet)
  end
end
