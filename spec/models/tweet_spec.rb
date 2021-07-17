require 'rails_helper'

RSpec.describe Tweet, type: :model do
  before do
    @tweet = FactoryBot.build(:tweet)
  end
  describe 'ツイート新規投稿' do
    context '新規投稿できる時' do
      it 'bodyが存在している場合に投稿ができる' do
        expect(@tweet).to be_valid
      end
    end

    context '新規投稿ができない時' do
      it 'bodyが150文字を超える場合' do
        @tweet.body = 'あ' * 151
        @tweet.valid?
        expect(@tweet.errors.full_messages).to include('投稿フォームは150文字以内で入力してください')
      end

      it 'bodyが空の場合' do
        @tweet.body = ''
        @tweet.valid?
        expect(@tweet.errors.full_messages).to include('投稿フォームを入力してください')
      end
    end
  end
end
