require 'rails_helper'

RSpec.describe "Places", type: :request do
  describe 'ログインせずにアクションを実行した場合' do
    it 'ログイン画面にリダイレクトされる' do
      get new_group_invite_path(create(:group))
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe 'GET /groups/:group_id/places/new' do
    it '行きたい場所作成画面が表示される' do
      sign_in create(:user)
      get new_group_place_path(create(:group))
      expect(response).to have_http_status 200
    end
  end
end
