require 'rails_helper'

RSpec.describe "Users", type: :request do
  before do
    @user = FactoryBot.create(:user)
  end
  describe "GET /sign_in" do
    context 'ログインしている場合' do
      it 'ログインしたときにメモのindexページで正常にレスポンスが返ってくるか' do
        sign_in @user
        get memos_path
        expect(response.status).to eq(200)
      end
    end

    context 'ログインしていない場合' do
      it 'ログインページにリダイレクトしているか' do
        get memos_path
        expect(response.status).to eq(302)
      end
    end
  end

  describe "GET /show" do
    it 'ユーザーのshowページで正常にレスポンスが返ってくるか' do
      sign_in @user
      get user_path(@user)
      expect(response.status).to eq(200)
    end

    it 'ユーザーのshowページで正常にニックネームが表示されているか' do
      sign_in @user
      get user_path(@user)
      expect(response.body).to include(@user.nickname)
    end
  end
end
