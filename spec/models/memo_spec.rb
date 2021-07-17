require 'rails_helper'

RSpec.describe Memo, type: :model do
  before do
    @memo = FactoryBot.build(:memo)
  end
  describe 'メモ新規登録' do
    context '新規登録ができる時' do
      it '全てのカラムが存在している場合に登録ができる' do
        expect(@memo).to be_valid
      end
    end

    context '新規登録ができない時' do
      it '日付が空だと登録できない' do
        @memo.start_time = ''
        @memo.valid?
        expect(@memo.errors.full_messages).to include('日付を入力してください')
      end

      it '日付は明日以降の登録はできない' do
        @memo.start_time = '2023/01/01'
        @memo.valid?
        expect(@memo.errors.full_messages).to include('日付は今日までのを選択してください')
      end

      it '種目は空だと登録できない' do
        @memo.training_content = ''
        @memo.valid?
        expect(@memo.errors.full_messages).to include('種目を入力してください')
      end

      it '種目の文字数が20文字を超えると登録ができない' do
        @memo.training_content = 'あ' * 21
        @memo.valid?
        expect(@memo.errors.full_messages).to include('種目は20文字以内で入力してください')
      end

      it '重さが空だと登録ができない' do
        @memo.weight = ''
        @memo.valid?
        expect(@memo.errors.full_messages).to include('重量を入力してください')
      end

      it '重さが1未満の場合は登録が出来ない' do
        @memo.weight = 1
        @memo.valid?
        expect(@memo.errors.full_messages).to include('重量は半角数字で1~999以内で入力してください')
      end

      it '重さが1000以上の場合は登録が出来ない' do
        @memo.weight = 1000
        @memo.valid?
        expect(@memo.errors.full_messages).to include('重量は半角数字で1~999以内で入力してください')
      end

      it '重さが全角数字の場合は登録が出来ない' do
        @memo.weight = '９９９'
        @memo.valid?
        expect(@memo.errors.full_messages).to include('重量は半角数字で1~999以内で入力してください')
      end

      it '重さが全角文字の場合は登録が出来ない' do
        @memo.weight = 'あああ'
        @memo.valid?
        expect(@memo.errors.full_messages).to include('重量は半角数字で1~999以内で入力してください')
      end

      it '重さが半角英字の場合は登録が出来ない' do
        @memo.weight = 'aaa'
        @memo.valid?
        expect(@memo.errors.full_messages).to include('重量は半角数字で1~999以内で入力してください')
      end

      it '回数が空の場合は登録が出来ない' do
        @memo.training_time = ''
        @memo.valid?
        expect(@memo.errors.full_messages).to include('回数を入力してください')
      end

      it '回数が0場合は登録が出来ない' do
        @memo.training_time = 0
        @memo.valid?
        expect(@memo.errors.full_messages).to include('回数は半角数字で1~100以内で入力してください')
      end

      it '回数が100を超える場合は登録が出来ない' do
        @memo.training_time = 101
        @memo.valid?
        expect(@memo.errors.full_messages).to include('回数は半角数字で1~100以内で入力してください')
      end

      it '回数が全角数字の場合は登録が出来ない' do
        @memo.training_time = '１００'
        @memo.valid?
        expect(@memo.errors.full_messages).to include('回数は半角数字で1~100以内で入力してください')
      end

      it '回数が全角文字の場合は登録が出来ない' do
        @memo.training_time = 'あああ'
        @memo.valid?
        expect(@memo.errors.full_messages).to include('回数は半角数字で1~100以内で入力してください')
      end

      it '回数が全角英字の場合は登録が出来ない' do
        @memo.training_time = 'aaa'
        @memo.valid?
        expect(@memo.errors.full_messages).to include('回数は半角数字で1~100以内で入力してください')
      end
    end
  end
end
