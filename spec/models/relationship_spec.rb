require 'rails_helper'

RSpec.describe Relationship, type: :model do
  before do
    @user1 = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)
    @relationship = FactoryBot.build(:relationship, follower_id: @user1.id, following_id: @user2.id)
    # sleep 0.1
  end
  describe 'フォロー機能' do
    context '保存できる場合' do
      it '全てのパラメーターが揃っていれば保存できる' do
        expect(@relationship).to be_valid
      end
    end
    context '保存できない場合' do
      it 'follower_idがnilの場合は保存ができない' do
        @relationship.follower_id = nil
        @relationship.save
        expect(@relationship.errors.full_messages).to include('Followerを入力してください')
      end
      it 'following_idがnilの場合は保存ができない' do
        @relationship.following_id = nil
        @relationship.save
        expect(@relationship.errors.full_messages).to include('Followingを入力してください')
      end
      it 'follower_idとfollowing_idの組み合わせは一意でなければ保存ができない' do
        @relationship.save
        another_relationship = FactoryBot.build(:relationship, follower_id: @relationship.follower_id,
                                                               following_id: @relationship.following_id)
        another_relationship.valid?
        expect(another_relationship.errors.full_messages).to include('Followerはすでに存在します')
      end
      it 'follower_idとfollowing_idが同じの場合は保存ができない(自分自身をフォローできない)' do
        relationship = FactoryBot.build(:relationship, follower_id: @relationship.follower_id,
                                                       following_id: @relationship.follower_id)
        sleep 0.1
        relationship.save
        expect(relationship.errors.full_messages).to include('Followerが自分の場合はフォローできません')
      end
    end
  end
end
