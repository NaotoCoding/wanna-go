require 'rails_helper'

RSpec.describe "RejectedInvites", type: :request do
  describe 'ログインせずにアクションを実行した場合' do
    it 'ログイン画面にリダイレクトされる' do
      post group_invite_rejected_invites_path(create(:group), create(:invite))
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe 'POST /groups/:group_id/invites/:invite_id/rejected_invites' do
    let!(:group) { create(:group) }
    let(:user) { create(:user) }
    let(:invite) { create(:invite, group:, user:) }

    before do
      sign_in user
    end

    it 'rejected_invitesテーブルのレコードが保存される' do
      expect { post group_invite_rejected_invites_path(group, invite) }.to change(RejectedInvite, :count).by(1)
    end

    it '招待一覧画面にリダイレクトされる' do
      post group_invite_rejected_invites_path(group, invite)
      expect(response).to redirect_to invites_path
    end
  end
end
