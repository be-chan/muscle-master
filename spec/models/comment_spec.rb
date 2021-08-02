require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @comment = FactoryBot.build(:comment)
  end
  describe 'コメント新規投稿' do
    context '新規投稿できる時' do
      it '全てのカラムがある場合は登録できる' do
        expect(@comment).to be_valid
      end
    end
    context '新規投稿できない時' do
      it 'bodyが空の場合は登録できない' do
        @comment.body = ''
        @comment.valid?
        expect(@comment.errors.full_messages).to include('コメントを入力してください')
      end
      it 'bodyが150文字超える場合は登録できない' do
        @comment.body = 'あ' * 151
        @comment.valid?
        expect(@comment.errors.full_messages).to include('コメントは150文字以内で入力してください')
      end
    end
    
  end
end
