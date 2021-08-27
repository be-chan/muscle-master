require 'rails_helper'


RSpec.describe "Tweets", type: :request do
  before do
    @tweet = FactoryBot.create(:tweet)
    sign_in @tweet.user
  end
  describe "GET /index" do
    it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do
      get tweets_path
      expect(response.status).to eq(200)
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みのツイートのテキストが存在する' do 
      get tweets_path
      expect(response.body).to include(@tweet.body)
    end
  end 

  describe "GET /show" do
    it 'showアクションにリクエストすると正常にレスポンスが返ってくる' do
      get tweet_path(@tweet)
      expect(response.status).to eq(200)
    end
    it 'showアクションにリクエストするとレスポンスに投稿済みのツイートのテキストが存在する' do 
      get tweet_path(@tweet)
      expect(response.body).to include(@tweet.body)
    end
    it 'showアクションにリクエストするとレスポンスにコメント一覧表示部分が存在する' do 
      get tweet_path(@tweet)
      expect(response.body).to include('コメント一覧')
    end
  end
end
