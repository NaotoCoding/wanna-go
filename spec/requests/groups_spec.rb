require 'rails_helper'

RSpec.describe "Groups", type: :request do
  describe 'ログインせずにアクションを実行した場合' do
    it 'ログイン画面にリダイレクトされる' do
      get root_path
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe "GET /" do
    it 'ログインしているユーザーが参加中のグループ一覧画面が表示される' do
      sign_in create(:user)
      get root_path
      expect(response).to have_http_status 200
    end
  end
end
