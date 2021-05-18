require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録ができる時' do
      it 'nickname, email, password, password_confirmationが存在すれば登録できる' do
        expect(@user).to be_valid
      end

      it 'introductionがなくても登録ができる' do
        @user.introduction = ''
        expect(@user).to be_valid
      end
    end

    context '新規登録ができない時' do
      it 'nicknameが空だと登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('ユーザー名を入力してください')
      end

      it 'nicknameが21字以上だと登録できない' do
        @user.nickname = 'あ' * 21
        @user.valid?
        expect(@user.errors.full_messages).to include('ユーザー名は20文字以内で入力してください')
      end

      it 'emailが空だと登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('メールアドレスを入力してください')
      end

      it 'emailが一意性がない場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('メールアドレスはすでに存在します')
      end

      it 'emailが@が含まれない場合は登録できない' do
        @user.email = 'test.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('メールアドレスは不正な値です')
      end

      it 'passwordが空の場合は登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードを入力してください')
      end

      it 'passwordが5文字以下の場合は登録できない' do
        @user.password = '1234a'
        @user.password_confirmation = '1234a'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end

      it 'passwordが半角数字のみでは登録できない' do
        @user.password = '000000'
        @user.password_confirmation = '000000'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは半角英数字混合６文字以上で入力してください', 'パスワード(確認用)は不正な値です')
      end

      it 'passwordが半角英字のみでは登録できない' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは半角英数字混合６文字以上で入力してください', 'パスワード(確認用)は不正な値です')
      end

      it 'passwordが全角では登録できない' do
        @user.password = '００００００'
        @user.password_confirmation = '００００００'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは半角英数字混合６文字以上で入力してください', 'パスワード(確認用)は不正な値です')
      end

      it 'passwordが入力されていても,password_confirmationが入力されていないと登録できない' do
        @user.password = '12345a'
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワード(確認用)とパスワードの入力が一致しません', 'パスワード(確認用)は不正な値です')
      end

      it 'passwordとpassword_confirmationが一致していないと登録できない' do
        @user.password = '12345a'
        @user.password_confirmation = '67890a'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワード(確認用)とパスワードの入力が一致しません')
      end

      it 'introductionが1001字以上だと登録できない' do
        @user.introduction = 'あ' * 1001
        @user.valid?
        expect(@user.errors.full_messages).to include('自己紹介は1000文字以内で入力してください')
      end
    end
  end
end
