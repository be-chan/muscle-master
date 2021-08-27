require 'rails_helper'

RSpec.describe 'Memos', type: :request do
  before do
    @memo = FactoryBot.create(:memo)
    sign_in @memo.user
  end
  describe 'GET /memos' do
    it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do
      get memos_path
      expect(response.status).to eq(200)
    end

    it 'indexアクションにリクエストするとレスポンスに投稿済みのメモのトレーニング内容が存在する' do
      get tweets_path
      expect(response.body).to include(@memo.training_content)
    end
  end
end
