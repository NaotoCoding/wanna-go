require 'rails_helper'

RSpec.describe 'AcceptedInvites', type: :request do
  describe 'ログインせずにアクションを実行した場合' do
    it 'ログイン画面にリダイレクトされる' do
      post group_invite_accepted_invites_path(create(:group), create(:invite))
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe 'POST /groups/:group_id/invites/:invite_id/accepted_invites' do
    let!(:group) { create(:group) }
    let(:user) { create(:user) }
    let(:invite) { create(:invite, group:, user:) }

    before do
      sign_in user
    end

    it 'accepted_invitesテーブルにレコードが保存される' do
      expect { post group_invite_accepted_invites_path(group, invite) }.to change(AcceptedInvite, :count).by(1)
    end

    it 'group_usersテーブルにレコードが保存される' do
      expect { post group_invite_accepted_invites_path(group, invite) }.to change(GroupUser, :count).by(1)
    end
  end
end
