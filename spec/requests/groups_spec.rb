require 'rails_helper'

RSpec.describe 'Groups', type: :request do
  describe 'ログインせずにアクションを実行した場合' do
    it 'ログイン画面にリダイレクトされる' do
      group = create(:group)
      get group_path(group)
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe 'GET /groups/:id' do
    let(:group) { create(:group) }

    before do
      user = create(:user)
      create(:group_user, user:, group:)
      sign_in user
    end

    it 'グループの詳細画面が表示される' do
      get group_path(group)
      expect(response).to have_http_status 200
    end
  end
end
