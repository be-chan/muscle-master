require 'rails_helper'

RSpec.describe Like, type: :model do
  before do
    @like = FactoryBot.build(:like)
    sleep 0.1
  end
  describe 'いいねの正常値と異常値の確認' do
    context 'いいねができるとき' do
      it 'user_idとtweet_idがあれば保存ができる' do
        expect(@like).to be_valid
      end

      it 'tweet_idが同じでもuser_idが違う場合は保存ができる' do
        @like.save
        another_user = FactoryBot.create(:user)
        @like.user_id = another_user.id
        expect(@like).to be_valid
      end

      it 'user_idが同じでもtweet_idが違う場合は保存ができる' do
        @like.save
        another_tweet = FactoryBot.create(:tweet)
        @like.tweet_id = another_tweet.id
        expect(@like).to be_valid
      end
    end

    context 'いいねができないとき' do
      it 'user_idがなければ無効な状態であること' do
        @like.save
        @like.user_id = nil
        @like.valid?
        expect(@like.errors.full_messages).to include('Userを入力してください')
      end
      it 'tweet_idがなければ無効な状態であること' do
        @like.save
        @like.tweet_id = nil
        @like.valid?
        expect(@like.errors.full_messages).to include('Tweetを入力してください')
      end
      it '一つのtweet_idに2つの同じuser_idは保存できない(一意性)' do
        @like.save
        another_user_like = FactoryBot.build(:like, tweet_id: @like.tweet_id, user_id: @like.user_id)
        another_user_like.save
        another_user_like.user_id = @like.user_id
        another_user_like.valid?
        expect(another_user_like.errors.full_messages).to include('Userはすでに存在します')
      end
    end
  end
end
