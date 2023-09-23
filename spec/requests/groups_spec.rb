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

  describe 'GET /groups/new' do
    it 'グループ作成画面が表示される' do
      sign_in create(:user)
      get new_group_path
      expect(response).to have_http_status 200
    end
  end

  describe 'POST /groups' do
    before do
      sign_in create(:user)
    end

    subject(:create_group) { post groups_path, params: group_params }

    context '正常なパラメータを送信した場合' do
      let(:group_params) { { group: { name: 'テストグループ' } } }

      it 'groupが作成される' do
        expect { create_group }.to change(Group, :count).by(1)
      end

      it 'group_userが作成される' do
        expect { create_group }.to change(GroupUser, :count).by(1)
      end

      it 'groupの詳細画面にリダイレクトされる' do
        create_group
        expect(response).to redirect_to group_path(Group.last)
      end
    end

    context '不正なパラメータを送信した場合' do
      let(:group_params) { { group: { name: '' } } }

      it 'groupが作成されない' do
        expect { create_group }.not_to change(Group, :count)
      end

      it 'group_userが作成されない' do
        expect { create_group }.not_to change(GroupUser, :count)
      end

      it 'バリデーションエラーが返される' do
        create_group
        expect(response).to have_http_status 422
      end
    end
  end
end
