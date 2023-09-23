require 'rails_helper'

RSpec.describe 'Invites', type: :request do
  describe 'ログインせずにアクションを実行した場合' do
    it 'ログイン画面にリダイレクトされる' do
      get new_group_invite_path(create(:group))
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe 'GET /invites' do
    it '未確認招待一覧画面が表示される' do
      sign_in create(:user)
      get invites_path
      expect(response).to have_http_status 200
    end
  end

  describe 'GET /groups/:group_id/invites/new' do
    let(:user) { create(:user) }
    let(:group) { create(:group) }

    before do
      sign_in user
      create(:group_user, user:, group:)
    end

    it '招待作成画面が表示される' do
      get new_group_invite_path(group)
      expect(response).to have_http_status 200
    end
  end

  describe 'POST /groups/:group_id/invites' do
    let(:inviter) { create(:user) }
    let(:invitee) { create(:user) }
    let(:group) { create(:group) }

    before do
      sign_in inviter
      create(:group_user, user: inviter, group:)
    end

    subject(:post_invite) { post group_invites_path(group), params: invite_params }

    context '正常なパラメータの場合' do
      let(:invite_params) { { unique_code: invitee.unique_code } }

      it 'inviteが保存される' do
        expect { post_invite }.to change(Invite, :count).by(1)
      end

      it 'グループ詳細画面にリダイレクトされる' do
        post_invite
        expect(response).to redirect_to group_path(group)
      end
    end

    context '存在しないユーザーのunique_codeを入力した場合' do
      let(:invite_params) { { unique_code: 'invalid_unique_code' } }

      it 'inviteが保存されない' do
        expect { post_invite }.not_to(change(Invite, :count))
      end

      it 'バリデーションエラーが返る' do
        post_invite
        expect(response).to have_http_status 422
      end
    end

    context '既にグループに参加しているユーザーのunique_codeを入力した場合' do
      let(:invite_params) { { unique_code: inviter.unique_code } }

      it 'inviteが保存されない' do
        expect { post_invite }.not_to(change(Invite, :count))
      end

      it 'バリデーションエラーが返る' do
        post_invite
        expect(response).to have_http_status 422
      end
    end
  end
end
