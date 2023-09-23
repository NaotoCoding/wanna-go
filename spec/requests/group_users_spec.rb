require 'rails_helper'

RSpec.describe "GroupUsers", type: :request do
  describe 'ログインせずにアクションを実行した場合' do
    it 'ログイン画面にリダイレクトされる' do
      group = create(:group)
      get group_group_users_path(group)
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe 'GET /groups/:group_id/group_users' do
    it 'グループのメンバー一覧画面が表示される' do
      user = create(:user)
      sign_in user
      get group_group_users_path(create(:group, owner: user))
      expect(response).to have_http_status 200
    end
  end
end
